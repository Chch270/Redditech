import 'package:flutter/material.dart';
import 'package:redditech/screens/home_screen.dart';
import 'package:redditech/screens/profil_screen.dart';
import 'package:redditech/screens/search_screen.dart';
import 'package:redditech/widgets/appbar_widget.dart';
import 'package:redditech/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _bodyWidgetList = <Widget>[
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        color: const Color(0xFFFF5710),
        title: 'ReddiTech',
        icon: _selectedIndex != 1
            ? const Icon(Icons.settings)
            : const Icon(
                Icons.search,
                size: 35.0,
              ),
        function: () {
          if (_selectedIndex != 1) {
            Navigator.pushNamed(context, '/userSettings');
          } else {
            showSearch(context: context, delegate: SearchBar());
          }
        },
      ),
      body: _bodyWidgetList[_selectedIndex],
      bottomNavigationBar:
          buildBottomNAvBar(context, _selectedIndex, _onItemTapped),
    );
  }
}
