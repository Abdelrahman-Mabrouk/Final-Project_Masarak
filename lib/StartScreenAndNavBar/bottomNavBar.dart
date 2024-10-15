import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key , required this.index});
  final int index;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index -1; // Correct way to initialize the index
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index != currentIndex) { // Check if the new index is different
              setState(() {
                currentIndex = index;
              });
              // Navigate only if the index is different
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/Setting');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/TripDetails');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/homePage');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/MetroLines');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/TicketPrice');
                  break;
              }
            }
          },
          backgroundColor:  Color(0xffff9735),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(110, 255, 255, 255),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              icon: Icon(Icons.settings),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              activeIcon: Icon(Icons.show_chart,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              activeIcon: Icon(Icons.confirmation_number,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}