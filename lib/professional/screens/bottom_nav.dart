
import 'package:blaemuya/professional/professional_jobs_section.dart';
import 'package:blaemuya/professional/professional_notifications.dart';
import 'package:blaemuya/professional/screens/Professional_payment.dart';

import 'package:blaemuya/professional/screens/pHome.dart';
import 'package:blaemuya/professional/screens/professional_profile.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProfessionalBottomBar extends ConsumerStatefulWidget {
  const ProfessionalBottomBar({super.key});

  @override
  _ProfessionalBottomBarState createState() => _ProfessionalBottomBarState();
}

class _ProfessionalBottomBarState extends ConsumerState<ProfessionalBottomBar> {
  int _selectedIndex = 0; 
 
 final List<Widget>  _pages = [
    ProfessionalHome(),
    JobScreen(),
    ProfessionalProfile(),
    ProfessionalNotifications(),
    ProfessionalPayment(),
    

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
            icon: Icon(Icons.business_center),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
        backgroundColor:primaryColor, 
        selectedFontSize: 14, 
        unselectedFontSize: 10, 
        iconSize: 26, 
        onTap: _onItemTapped, 
      ),
    );
  }
}