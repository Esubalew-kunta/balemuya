
import 'package:blaemuya/customer/screens/customer_home.dart';
import 'package:blaemuya/customer/screens/customer_jobs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerBottomNav extends ConsumerStatefulWidget {
  const CustomerBottomNav({super.key});

  @override
  _CustomerBottomNavState createState() => _CustomerBottomNavState();
}

class _CustomerBottomNavState extends ConsumerState<CustomerBottomNav> {
  int _selectedIndex = 0; 
 
 final List<Widget>  _pages = [
    CustomerHomePage(),
    CustomerJobsList(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    

    ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Payment',
          ),
        ],
        currentIndex: _selectedIndex,

        selectedItemColor: Colors.brown, 
        unselectedItemColor: Colors.white, 
        backgroundColor: const Color.fromRGBO(9, 15, 44, 1), 
        selectedFontSize: 14, 
        unselectedFontSize: 10, 
        iconSize: 26, 
        onTap: _onItemTapped, 
      ),
    );
  }
}