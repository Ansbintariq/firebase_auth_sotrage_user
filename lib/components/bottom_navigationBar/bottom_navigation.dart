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
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false; // Let the default back button behavior happen
        else {
          // Move to the home screen by setting the index to 0

          if (selectedindex == 0) {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);

                      //retun true;

                    },
                  ),
                ],
              ),
            );
          }
          else{
            setState(() {
              selectedindex = 0;
            });
          }
          return false;
        }
        ;
        // Prevent the app from exiting
      },
      child: Scaffold(
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
            unselectedItemColor: const Color.fromARGB(255, 34, 195, 207),
            selectedItemColor: const Color.fromARGB(255, 4, 98, 187),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket), label: "Second"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favourite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
      ),
    );
  }
}
