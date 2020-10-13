import 'package:capp/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final CollectionReference chatList =
      FirebaseFirestore.instance.collection('ChatList');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: chatList.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                height: 1.0,
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final user =
                    ChatListModel.fromSnapshot(snapshot.data.docs[index]);
                final selectedChatID = snapshot.data.docs[index].id;
                final otherUserID = snapshot.data.docs[index]['otherUser'];
                final otherUserName = snapshot.data.docs[index]['name'];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  chatWithUserID: selectedChatID,
                                  otherUserID: otherUserID,
                                  otherUserName: otherUserName,
                                )));
                  },
                );
              },
            );
          }),
    );
  }
}

class ChatListModel {
  final String name;
  final String otherChatID;
  final DocumentReference reference;

  ChatListModel.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['otherUser'] != null),
        name = map['name'],
        otherChatID = map['otherUser'];

  ChatListModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
