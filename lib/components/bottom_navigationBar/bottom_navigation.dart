import 'package:flutter/material.dart';

import '../../Screens/home_screen/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/second/second_screen.dart';
import '../../screens/third/third_screen.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  int selectedindex = 0;
  List bottomscreen = [
    const HomeScreen(),
    const SecondScreen(),
    const ThirdScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: bottomscreen.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: (value) {
            //  print(value);
            setState(() {
              selectedindex = value;
            });
          },
          showUnselectedLabels: true,
          unselectedItemColor: Color.fromARGB(255, 34, 195, 207),
          selectedItemColor: Color.fromARGB(255, 4, 98, 187),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket), label: "Second"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favourite"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
