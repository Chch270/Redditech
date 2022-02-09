import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNAvBar(
    BuildContext context, int index, Function(int) func) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profil',
      ),
    ],
    currentIndex: index,
    selectedItemColor: Colors.white,
    onTap: func,
    backgroundColor: const Color(0xFFFF3025),
    unselectedItemColor: Colors.grey.shade900,
  );
}
