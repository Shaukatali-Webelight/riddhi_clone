import 'package:flutter/material.dart';
import 'package:riddhi_clone/widgets/common/riddhi_nav_bar.dart';

class RiddhiNavBarExample extends StatefulWidget {
  const RiddhiNavBarExample({super.key});

  @override
  State<RiddhiNavBarExample> createState() => _RiddhiNavBarExampleState();
}

class _RiddhiNavBarExampleState extends State<RiddhiNavBarExample> {
  int selectedIndex = 1; // Default to Customer (index 1) as shown in screenshot

  final List<Widget> screens = [
    const Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Customer Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Start Day Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Meetings Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('More Screen', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: screens[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RiddhiNavBar(
            selectedIndex: selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
