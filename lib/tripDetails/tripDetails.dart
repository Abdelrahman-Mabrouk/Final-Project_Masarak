import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masarak/tripDetails/detailsCard.dart';
import 'package:masarak/tripDetails/directionTop.dart';
import 'package:masarak/tripDetails/noDirection.dart';

import '../Map/metro_route_finder.dart';

class TripDetails extends StatefulWidget {
  final MetroRouteFinder? metroRouteFinder;

  const TripDetails({super.key, required this.metroRouteFinder});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final bool noDirection = false;
  final bool transDirection = false;
  late List<Map<dynamic, dynamic>> data;

  // this. startStation,
  // this.endStation,
  // thirouteStations

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return noDirection
        ? NoDirection()
        : Scaffold(
            appBar: AppBar(backgroundColor: Color.fromARGB(255, 2, 11, 80)),
            backgroundColor: Color.fromARGB(255, 248, 248, 230),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  DirectionTop(
                      fromStation: widget.metroRouteFinder!.startStation!,
                      toStation: widget.metroRouteFinder!.endStation!),
                  Container(
                    width: double.infinity,
                    height: 260,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailsCard(
                                textDesc: "السعر",
                                iconDesc: Icons.money,
                                classDetail: "جنيها",
                                classNum: "20"),
                            DetailsCard(
                                textDesc: "المحطات",
                                iconDesc: CupertinoIcons.tram_fill,
                                classDetail: "محطة",
                                classNum: "15"),
                            DetailsCard(
                                textDesc: "الوقت",
                                iconDesc: CupertinoIcons.clock,
                                classDetail: "دقيقة",
                                classNum: "30")
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 125,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(25))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("تفاصيل رحلتك",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27)),
                              Text("هتركب المترو و بلا بلا",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 13),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 2, 11, 80),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 5,
                                        offset: Offset(2, 2))
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(CupertinoIcons
                                      .arrow_up_left_arrow_down_right),
                                  color: Colors.orange,
                                  iconSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 130.0, right: 30),
                              child: Text("خط سير المترو",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 27)),
                            ),
                            Icon(
                              Icons.navigation_outlined,
                              color: Colors.black,
                              size: 30,
                            )
                          ],
                        ),
                        Divider(
                            thickness: 5,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.black.withOpacity(0.1)),
                        SizedBox(height: 15),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  children: [
                                    Text(
                                        "اتجاه عدلي منصور (السلام) - الخط الثالث",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                    Divider(
                                        thickness: 3,
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black.withOpacity(0.1)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(8.0),
                                            itemCount: widget.metroRouteFinder!
                                                .routeStations.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Text(
                                                  widget.metroRouteFinder!
                                                      .routeStations[index],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                  textAlign: TextAlign.right,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 2, 11, 80),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.train_outlined,
                                          color: Colors.black,
                                          size: 45,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            transDirection
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "هتحول الاتجاه",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Divider(
                                                thickness: 3,
                                                indent: 10,
                                                endIndent: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                          "هتمشي 4 دقائق, 100 متر",
                                                          style: TextStyle(
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.circle,
                                                          size: 8),
                                                      SizedBox(height: 10),
                                                      Icon(Icons.circle,
                                                          size: 8),
                                                      SizedBox(height: 10),
                                                      Icon(Icons.circle,
                                                          size: 8),
                                                      SizedBox(height: 10),
                                                      Icon(Icons.circle,
                                                          size: 8),
                                                      SizedBox(height: 10),
                                                      Icon(Icons.circle,
                                                          size: 8),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .directions_walk_outlined,
                                                    color: Colors.black,
                                                    size: 45,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Column(
                                            children: [
                                              Text(
                                                  "اتجاه عدلي منصور (السلام) - الخط الثالث",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Divider(
                                                  thickness: 3,
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      itemCount: widget
                                                          .metroRouteFinder!
                                                          .routeStations
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      4.0),
                                                          child: Text(
                                                            widget.metroRouteFinder!
                                                                    .routeStations[
                                                                index],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 25),
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 2, 11, 80),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.white,
                                                            size: 25,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.white,
                                                            size: 25,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.train_outlined,
                                                    color: Colors.black,
                                                    size: 45,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
