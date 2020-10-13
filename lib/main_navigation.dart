import 'package:capp/chat_list.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  List<Widget> _widgets = <Widget>[
    Text(
      'Index 1: Business',
    ),
    ChatList(),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App'), centerTitle: true),
      body: SafeArea(child: Center(
        child: _widgets.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text('Chats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            title: Text('Friends'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
