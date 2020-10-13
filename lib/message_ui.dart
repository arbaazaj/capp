import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageUI extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final String name;

  const MessageUI({Key key, this.doc, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 8.0, right: 8.0, top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.amber,
                    blurRadius: 1,
                    offset: Offset(-1, 1),
                    spreadRadius: 0.1
                ),
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 4.0),
                        child: Text(
                          doc.data()['message'],
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 12.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}