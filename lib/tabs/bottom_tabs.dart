import 'package:flutter/material.dart';
import 'package:xcrowme/screens/history_screen/index.dart';
import 'package:xcrowme/screens/home_screen/index.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';
import 'package:xcrowme/screens/sellers_screen/index.dart';
import 'package:get/get.dart';

class BottomTab extends StatefulWidget {
  final int initialIndex;

  const BottomTab({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(newStores: [],),
    SellersScreen(),
    ProfileScreen(sellerId: '', initialValue: ''),
    HistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Remaining code remains the same
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Sellers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 5, 20, 68),
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 10,
      ),
    );
  }
}
