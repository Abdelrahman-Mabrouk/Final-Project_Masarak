import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dropdown.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool showContainers = false;
  List<String> stations = [];
  String? fromPlace;
  String? toPlace;
  String? numofpeople;
  String fareMessage = '';
  int stationCount = 0;
  int time=0;
  @override
  void initState() {
    super.initState();
    // Load the station names when the widget is initialized
    loadStations().then((value) {
      setState(() {
        stations = value; // Update the stations list
      });
    });
  }

  Future<List<String>> loadStations() async {
    try {
      final String response = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');
      final data = json.decode(response); // Decode the JSON data

      // Extract station names from the loaded JSON
      return List<String>.from(data.map((station) => station['name']));
    } catch (e) {
      print('Error loading stations: $e'); // Print error details for debugging
      return []; // Return an empty list in case of error
    }
  }
  void calculateFare() {
    if (fromPlace == null || toPlace == null) {
      setState(() {
        fareMessage = 'Invalid selection. Please select valid stations.';
      });
      return ;
    }

    int fromIndex = stations.indexOf(fromPlace!);
    int toIndex = stations.indexOf(toPlace!);

    if (fromIndex == -1 || toIndex == -1) {
      setState(() {
        fareMessage = 'Invalid selection. Please select valid stations.';
      });
      return ;
    }

    int calculatedStationCount = (toIndex - fromIndex).abs();
    int price;

    if (calculatedStationCount <= 9) {
      price = 8;
    } else if (calculatedStationCount <= 16) {
      price = 10;
    } else if (calculatedStationCount <= 23) {
      price = 15;
    } else {
      price = 20;
    }

    // Multiply by the number of people
    int totalPrice = price * int.parse(numofpeople ?? '1');

    setState(() {
      fareMessage = '$totalPriceجنيه ';  // Display the total price
      stationCount = calculatedStationCount;
      time= (stationCount * 2.25) as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 600,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/image_inticket.png', fit: BoxFit.fill),
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
              mainAxisAlignment: MainAxisAlignment.start, // Aligns content at the start
              children: [
                const SizedBox(height: 30),
                Container(
                  width: 120, // You can adjust the size of the circle
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 105, 226, 1), // Circle color
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        blurRadius: 10, // Softness of the shadow
                        spreadRadius: 2, // Size of the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/photoAndIcon/ic_ticket.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'حساب سعر التذكرة',
                  style: TextStyle(color: Color.fromRGBO(12, 105, 226, 1), fontSize: 30),
                ),
                const SizedBox(height: 20),
                stations.isNotEmpty
                    ? buildDropdown(
                  hintText: "من",
                  items: stations, // Use the dynamically loaded stations
                  iconTextSpace: 300.0,
                  assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                  iconPadding: 10.0,
                  dropdownWidth: 400.0,
                  currentValue: fromPlace,
                  onChanged: (String? newValue) {
                    setState(() {
                      fromPlace = newValue; // Update the selected value
                      calculateFare(); // Calculate fare when 'from' place changes
                    });
                  },
                )
                    : const CircularProgressIndicator(), // Show a loading indicator until stations are loaded

                const SizedBox(height: 20),

                stations.isNotEmpty
                    ?
                buildDropdown(
                  hintText: "الي",
                  items: stations, // Use the dynamically loaded stations
                  iconTextSpace: 300.0,
                  assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                  iconPadding: 10.0,
                  dropdownWidth: 400.0,
                  currentValue: toPlace,
                  onChanged: (String? newValue) {
                    setState(() {
                      toPlace = newValue; // Update the selected value
                      calculateFare(); // Calculate fare when 'to' place changes
                    });
                  },
                )
                    : const CircularProgressIndicator(), // Show a loading indicator until stations are loaded

                const SizedBox(height: 20),

                buildDropdown(
                  hintText: "عداد الافراد",
                  items: ['1', '2', '3', '4'],
                  iconTextSpace: 220.0, // Space between the icon and hint
                  assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                  iconPadding: 10.0,
                  dropdownWidth: 400.0,
                  currentValue: numofpeople, // Pass the current selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      numofpeople = newValue; // Update the selected value
                    });
                  },
                ),
                const SizedBox(height: 30),

                FilledButton(
                  onPressed: () {
                    if (fromPlace != null && toPlace != null && numofpeople != null) {
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
                    fixedSize: WidgetStateProperty.all(const Size(370, 60)),
                    backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(12, 105, 226, 1)),
                    elevation: WidgetStateProperty.all(10),
                    overlayColor: WidgetStateProperty.all(Colors.lightBlue),
                    shadowColor: WidgetStateProperty.all(Colors.lightBlue),
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
                                const SizedBox(width: 40), // Optional padding on the left
                                Text(
                                  '$stationCount \nمحطات',
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 40), // Optional spacing between text and icon
                                Image.asset('assets/photoAndIcon/ic-metro.png'),
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
                                SizedBox(width: 20), // Optional padding on the left
                                Text(
                                  "$time \nدقيقة",
                                  style: TextStyle(fontSize: 20), // no need for const here
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 40), // Optional spacing between text and icon
                                Icon(Icons.access_time_outlined, size: 30),
                              ],
                            ),
                          )
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
                          padding: const EdgeInsets.only(right: 20.0), // Adjust the value as needed
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('..المبلغ اللي هتدفعه ', style: TextStyle(fontSize: 20)),
                              const SizedBox(height: 10), // Optional spacing between text and icon
                              Text(fareMessage, style: const TextStyle(fontSize: 25)), // Show the calculated fare message
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
}
}
