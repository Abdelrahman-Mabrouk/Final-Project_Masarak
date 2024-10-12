import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masarak/tripDetails/detailsCard.dart';
import 'package:masarak/tripDetails/directionTop.dart';
import 'package:masarak/tripDetails/noDirection.dart';

import '../Map/metro_route_finder.dart';
import '../StartScreenAndNavBar/bottomNavBar2.dart';

class TripDetails extends StatefulWidget {
  final MetroRouteFinder? metroRouteFinder;

  const TripDetails({super.key,  this.metroRouteFinder});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late List<Map<dynamic, dynamic>> data;
  late int ? numberOfStation = widget.metroRouteFinder!.routeStations1.length + widget.metroRouteFinder!.routeStations2.length;

  // this. startStation,
  // this.endStation,
  // thirouteStations

  @override
  void initState() {
    super.initState();
    // print("----------------------------------------------------------");
    // print(widget.metroRouteFinder!.isTransferStation);
  }

  @override
  Widget build(BuildContext context) {
    return (widget.metroRouteFinder == null)
        ? NoDirection()
        : Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 2),
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
                                classNum: (numberOfStation!>23)?"20":(numberOfStation!>=17 && numberOfStation!<=23)?"15":(numberOfStation!>=10 && numberOfStation!<=16)?"10":"8"
                            ),
                            DetailsCard(
                                textDesc: "المحطات",
                                iconDesc: CupertinoIcons.tram_fill,
                                classDetail: "محطة",
                                classNum: "${numberOfStation}"),
                            DetailsCard(
                                textDesc: "الوقت",
                                iconDesc: CupertinoIcons.clock,
                                classDetail: "دقيقة",
                                classNum:  "${(numberOfStation)!*2}"
                            )
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
                              Text("هتركب المترو وتركب محطة ${(widget.metroRouteFinder!.isTransferStation)?(" وهتنزل محطة ${widget.metroRouteFinder!.nameOftransferStation} عشان تحول للخط ${widget.metroRouteFinder!.endLine} ولما تركب من هناك خليك راكب لحد متوصل لمحطة ${widget.metroRouteFinder!.endStation} و يبق كد حمدلله علي سلامتك ") :  "و خليك راكب لحد متوصل لمحطة ${widget.metroRouteFinder!.endStation} ويبق كد حمدلله علي سلامتك "} ${widget.metroRouteFinder!.startStation}",
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
                                  onPressed: () {_showFullScreenStations(context);},
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
                                        "${widget.metroRouteFinder!.nameOfLines[widget.metroRouteFinder!.startLine]}",
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
                                                .routeStations1.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Text(
                                                  widget.metroRouteFinder!
                                                      .routeStations1[index],
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
                                          height: (widget.metroRouteFinder!.routeStations1.length * 50.0),
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
 // ---------------------------------------------------------------------------------------------------------------------------
                             widget.metroRouteFinder!.isTransferStation
                                ? Column(
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
                                                  "${widget.metroRouteFinder!.nameOfLines[widget.metroRouteFinder!.endLine]}",
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
                                                          .routeStations2.length,
                                                      itemBuilder: (context, index) {
                                                        return Padding(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 4.0),
                                                          child: Text(
                                                            widget.metroRouteFinder!
                                                                .routeStations2[index],
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
                                                    height: (widget.metroRouteFinder!.routeStations2.length * 50.0),
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
    void _showFullScreenStations(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // يجعل الشاشة قابلة للتمرير
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9, // ارتفاع النافذة
            width: MediaQuery.of(context).size.width, // عرض كامل الشاشة
            child:
            ListView(
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
                                    .routeStations1.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      widget.metroRouteFinder!
                                          .routeStations1[index],
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
                              height: (widget.metroRouteFinder!.routeStations1.length * 50.0),
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
                widget.metroRouteFinder!.isTransferStation
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
                                "${widget.metroRouteFinder!.nameOfLines[widget.metroRouteFinder!.endLine]}",
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
                                        .routeStations2
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
                                              .routeStations2[
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
                                  height: (widget.metroRouteFinder!.routeStations1.length * 50.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 2, 11, 80),
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
          );
        },
      );
    }

  }

