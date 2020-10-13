import 'dart:ui';

import 'package:capp/message_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'chat_message.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUserID;
  final String otherUserID;
  final String otherUserName;

  const ChatScreen(
      {Key key,
      @required this.chatWithUserID,
      @required this.otherUserID,
      @required this.otherUserName})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isComposing = false;

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  fetchMessages() {
    Stream<QuerySnapshot> stream = messages
        .doc(widget.chatWithUserID)
        .collection(widget.otherUserID)
        .snapshots();
    return stream;
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              focusNode: _focusNode,
              controller: _textController,
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Theme.of(context).accentColor),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.otherUserName),
        ),
        body: Column(
          children: [
            Text('Me: ${widget.chatWithUserID}'),
            Text('Other: ${widget.otherUserID}'),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: fetchMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, index) => MessageUI(
                        doc: snapshot.data.docs[index],
                        name: widget.otherUserName,
                      ),
                    );
                  }),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );
    setState(() {
      _isComposing = false;
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }
}
