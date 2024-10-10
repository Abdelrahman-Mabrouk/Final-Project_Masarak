import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MetroRouteFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro Stations App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MetroStationsScreen(),
    );
  }
}

class MetroStationsScreen extends StatefulWidget {
  @override
  _MetroStationsScreenState createState() => _MetroStationsScreenState();
}

class _MetroStationsScreenState extends State<MetroStationsScreen> {
  List stations = [];
  String? startStation;
  String? endStation;
  List<String> routeStations = [];
  Map<String, List<int>> transferStations = {
    'العتبة': [2, 3],
    'الشهداء': [1, 2],
    'ناصر': [1, 3],
    'السادات': [1, 2]
  };

  @override
  void initState() {
    super.initState();
    loadStations();
  }

  // قراءة ملف JSON للمحطات
  Future<void> loadStations() async {
    String data = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');

    setState(() {
      stations = jsonDecode(data);
    });
  }

  // دالة لحساب المحطات بين خطين
  List<String> getStationsBetween(String start, String end) {
    List<String> result = [];

    int? startLine;
    int? endLine;

    // تحديد الخطين للمحطتين
    for (var station in stations) {
      if (station['name'] == start) startLine = station['line'];
      if (station['name'] == end) endLine = station['line'];
    }

    if (startLine == endLine) {
      return getStationsBetweenSameLine(start, end, startLine!);
    }

    // البحث عن محطة تحويل بين الخطين
    String? transferStation;
    for (var entry in transferStations.entries) {
      if (entry.value.contains(startLine) && entry.value.contains(endLine)) {
        transferStation = entry.key; // محطة التحويل التي تحتوي على الخطين
        break;
      }
    }

    if (transferStation != null) {
      result.addAll(getStationsBetweenSameLine(start, transferStation, startLine!));
      result.addAll(getStationsBetweenSameLine(end,transferStation,  endLine!));
    }

    return result;
  }

  // دالة لحساب المحطات بين محطتين على نفس الخط
  List<String> getStationsBetweenSameLine(String start, String end, int line) {
    List<String> result = [];
    bool inRange = false;

    for (var station in stations) {
      if (station['line'] == line) {
        if (station['name'] == start || station['name'] == end) {
          result.add(station['name']);
          if (inRange) break;
          inRange = !inRange;
        } else if (inRange) {
          result.add(station['name']);
          print("-------------------station['name']------------------------------");
          print(station['name']);
        }
      }
    }
    if(result[0]==endStation){result= result.reversed.toList();result.removeAt(0);}
    print("-------------------------------------------------");
    print(start);
    print(end);
    print("-------------------------------------------------");

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metro Route Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text("اختر محطة البداية"),
              value: startStation,
              onChanged: (newValue) {
                setState(() {
                  startStation = newValue;

                });
              },
              items: stations.map<DropdownMenuItem<String>>((station) {
                return DropdownMenuItem<String>(
                  value: station['name'],  // تعديل المفتاح إلى 'name'
                  child: Text(station['name']),  // تعديل المفتاح إلى 'name'
                );
              }).toList(),
            ),

            DropdownButton<String>(
              hint: Text("اختر محطة الوصول"),
              value: endStation,
              onChanged: (newValue) {
                setState(() {
                  endStation = newValue;
                });
              },
              items: stations.map<DropdownMenuItem<String>>((station) {
                return DropdownMenuItem<String>(
                  value: station['name'],  // تعديل المفتاح إلى 'name'
                  child: Text(station['name']),  // تعديل المفتاح إلى 'name'
                );
              }).toList(),
            ),

            ElevatedButton(
              onPressed: () {
                if (startStation != null && endStation != null) {
                  if (startStation == endStation) {
                    // عرض رسالة خطأ إذا كانت محطة البداية هي نفسها محطة النهاية
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("خطأ"),
                          content: Text("محطة البداية لا يمكن أن تكون هي نفسها محطة النهاية!"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("حسناً"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // استمر في العملية إذا كانت محطتي البداية والنهاية مختلفتين
                    setState(() {
                      routeStations = getStationsBetween(startStation!, endStation!);
                    });
                  }
                }
              },
              child: Text("عرض المسار"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: routeStations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(routeStations[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
