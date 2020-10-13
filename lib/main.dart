import 'package:capp/custom_themes.dart';
import 'package:capp/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'capp',
      theme: kAndroidDarkTheme,
      home: MainNavigation(),
    );
  }
}

class MyTestClass extends StatelessWidget {
  final String docID;

  MyTestClass({Key key, this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data.docs[index]['name']}'),
                  );
                });
          }),
    );
  }
}
