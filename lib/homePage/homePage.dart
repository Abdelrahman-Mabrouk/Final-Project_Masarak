import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../Map/metro_route_finder.dart';
import '../tripDetails/tripDetails.dart';
import '../Map/metro_route_finder.dart';
import '../tripDetails/tripDetails.dart';

class homePage extends StatefulWidget {
  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<homePage> {
  MetroRouteFinder routeFinder = MetroRouteFinder(); // إنشاء نسخة من كلاس MetroRouteFinder

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(routeFinder.stationsname);
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
                // Dropdown for selecting the start station with search functionality
                DropdownSearch<String>(
                  items: routeFinder.stationsname.toList(), // تحويل Set إلى List
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "اختر محطة البداية",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  selectedItem: routeFinder.startStation,
                  popupProps: PopupProps.menu(
                    showSearchBox: true, // تفعيل البحث
                    searchFieldProps: TextFieldProps(
                      autofocus: true, // لتفعيل البحث مباشرة عند فتح القائمة
                    ),
                  ),
                  filterFn: (station, filter) => station.toLowerCase().contains(filter.toLowerCase()),
                  onChanged: (String? newValue) {
                    setState(() {
                      routeFinder.startStation = newValue; // تحديث محطة البداية
                    });
                  },
                ),

                SizedBox(height: 20), // إضافة مسافة بين القائمتين

                // Dropdown for selecting the end station with search functionality
                DropdownSearch<String>(
                  items: routeFinder.stationsname.toList(), // تحويل Set إلى List
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "اختر محطة الوصول",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  selectedItem: routeFinder.endStation,
                  popupProps: PopupProps.menu(
                    showSearchBox: true, // تفعيل البحث
                    searchFieldProps: TextFieldProps(
                      autofocus: true, // لتفعيل البحث مباشرة عند فتح القائمة
                    ),
                  ),
                  filterFn: (station, filter) => station.toLowerCase().contains(filter.toLowerCase()),
                  onChanged: (String? newValue) {
                    setState(() {
                      routeFinder.endStation = newValue; // تحديث محطة الوصول
                    });
                  },
                ),

                SizedBox(height: 20), // إضافة مسافة

                // عرض النتائج المختارة لمحطة البداية والنهاية
                Text(
                  'محطة البداية: ${routeFinder.startStation ?? "لم يتم الاختيار"}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'محطة الوصول: ${routeFinder.endStation ?? "لم يتم الاختيار"}',
                  style: TextStyle(fontSize: 16),
                ),

    ElevatedButton(
    onPressed: () {
    if (routeFinder.startStation != null && routeFinder.endStation != null) {
    if (routeFinder.startStation == routeFinder.endStation) {
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
    // حساب المسار
    routeFinder.getStationsBetween(routeFinder.startStation!, routeFinder.endStation!);

    // الانتقال إلى صفحة عرض التفاصيل
    print("-------------------routeFinder.startStation----------------------------");
    print(routeFinder.startStation);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => TripDetails(
    metroRouteFinder: routeFinder,

    ),
    ),
    );
    }
    } else {
    // عرض رسالة خطأ إذا لم يتم اختيار المحطات
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text("خطأ"),
    content: Text("يرجى اختيار محطة البداية ومحطة النهاية!"),
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
    }
    },
    child: Text('عرض المسار'),
    ),
    ],
    ),
    ),
    );
    }
  }
