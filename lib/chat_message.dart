import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  final String _name = 'Arbaaz';

  ChatMessage({Key key, this.text, this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animationController, curve: Curves.easeOutSine),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundColor: Colors.lightGreen,
                child: Text(text[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Theme.of(context).accentColor),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}