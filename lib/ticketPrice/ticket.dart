import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';
import '../Map/metro_route_finder.dart';
import 'dropdown.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {

  MetroRouteFinder routeFinder = MetroRouteFinder();
  bool showContainers = false;
  String? fromPlace;
  String? toPlace;
  String? numofpeople;
  String fareMessage = '';
  int stationCount = 0;
  int time = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMetroStations();
  }
  Future<void> loadMetroStations() async {
    await routeFinder.loadStations();
    setState(() {}); // تحديث الواجهة بعد تحميل المحطات
  }
  void calculateFare() {

    if (fromPlace == null || toPlace == null || numofpeople == null) {
      setState(() {
        fareMessage =
        'Invalid selection. Please select valid stations and number of people.';
      });
      return;
    }
    routeFinder.getStationsBetween(fromPlace!, toPlace!);

    int fromIndex = routeFinder.stationsname.toList().indexOf(fromPlace!);
    int toIndex =  routeFinder.stationsname.toList().indexOf(toPlace!);

    if (fromIndex == -1 || toIndex == -1) {
      setState(() {
        fareMessage = 'Invalid selection. Please select valid stations.';
      });
      return;
    }

    int calculatedStationCount = routeFinder.routeStations1.length + routeFinder.routeStations2.length;;
    int price;
    if (calculatedStationCount == 0) {
      setState(() {
        fareMessage = 'Please select different stations.';
        stationCount = 0;
        time = 0;
      });
      return;
    }

    // Determine the price based on the number of stations
    if (calculatedStationCount <= 9) {
      price = 8;
    } else if (calculatedStationCount <= 16) {
      price = 10;
    } else if (calculatedStationCount <= 23) {
      price = 15;
    } else {
      price = 20;
    }

    // Calculate the total price for the number of people
    int totalPrice = price * int.parse(numofpeople!);

    setState(() {
      fareMessage = '$totalPrice جنيه'; // Display the total price
      stationCount = calculatedStationCount;
      time = (stationCount * 2).round(); // Update the time estimation
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 5),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 600,
            left: 0,
            right: 0,
            child: Image.asset(
                'assets/images/image_inticket.png', fit: BoxFit.fill),
          ),
          Positioned(
            right: 20,
            left: 20,
            top: 100,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(232, 232, 232, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: 900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(12, 105, 226, 1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/photoAndIcon/ic_ticket.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'حساب سعر التذكرة',
                    style: TextStyle(
                        color: Color.fromRGBO(12, 105, 226, 1), fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  routeFinder.stationsname.isNotEmpty
                      ? buildDropdown(
                    hintText: "من",
                    items: routeFinder.stationsname.toList(),
                    iconTextSpace: 300.0,
                    assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                    iconPadding: 10.0,
                    dropdownWidth: 400.0,
                    currentValue: fromPlace,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromPlace = newValue;
                        calculateFare();// Recalculate the fare
                      });
                    },
                  )
                      : const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  routeFinder.stationsname.isNotEmpty
                      ? buildDropdown(
                    hintText: "الي",
                    items: routeFinder.stationsname.toList(),
                    iconTextSpace: 300.0,
                    assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                    iconPadding: 10.0,
                    dropdownWidth: 400.0,
                    currentValue: toPlace,
                    onChanged: (String? newValue) {
                      setState(() {
                        toPlace = newValue;
                        calculateFare() ; // Recalculate the fare
                      });
                    },
                  )
                      : const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  buildDropdown(
                    hintText: "عداد الافراد",
                    items: ['1', '2', '3', '4'],
                    iconTextSpace: 220.0,
                    assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                    iconPadding: 10.0,
                    dropdownWidth: 400.0,
                    currentValue: numofpeople,
                    onChanged: (String? newValue) {
                      setState(() {
                        numofpeople = newValue;
                        calculateFare();
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  FilledButton(
                    onPressed: () {
                      if (fromPlace != null && toPlace != null &&
                          numofpeople != null) {
                        setState(() {
                          showContainers = true;
                        });
                      } else {
                        setState(() {
                          fareMessage = ' ';
                        });
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(370, 60)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(12, 105, 226, 1)),
                      elevation: MaterialStateProperty.all(10),
                      overlayColor: MaterialStateProperty.all(Colors.lightBlue),
                      shadowColor: MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text('احسب', style: TextStyle(fontSize: 25)),
                  ),
                  Visibility(
                    visible: showContainers,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 75,
                              width: 200,
                              child: Row(
                                children: [
                                  const SizedBox(width: 40),
                                  Text(
                                    '$stationCount \nمحطات',
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 40),
                                  Image.asset(
                                      'assets/photoAndIcon/ic-metro.png'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 75,
                              width: 140,
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Text(
                                    "$time \nدقيقة",
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 40),
                                  Icon(Icons.access_time_outlined, size: 30),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          height: 100,
                          width: 360,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('..المبلغ اللي هتدفعه ',
                                    style: TextStyle(fontSize: 20)),
                                const SizedBox(height: 10),
                                Text(fareMessage,
                                    style: const TextStyle(fontSize: 25)),
                              ],

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}