import 'dart:convert';
import 'package:flutter/services.dart';

class MetroRouteFinder {
  List stations = [];
  Set<String> stationsname = {};
  String? startStation;
  String? endStation;
  String? nameOftransferStation;
  int? startLine;
  int? endLine;
  List<String> routeStations1 = [];
  List<String> routeStations2 = [];
  Map<String, List<int>> transferStations = {
    'العتبة': [2, 3],
    'الشهداء': [1, 2],
    'جمال عبد الناصر': [1, 3],
    'السادات': [1, 2]
  };

  Map<int, String> nameOfLines = {
    1: "الخط الاول (حلوان, المرج الجديدة)",
    2: "الخط الثاني (المنيب , شبرا)",
    3: "الخط الثالث (عدلي منصور , محور روض الفرج)"
  };

  bool isTransferStation = false;

  Color getLineColorByName(String lineName) {
    if (lineName.contains("الخط الاول")) {
      return Color.fromARGB(255, 2, 11, 80); // Blue
    } else if (lineName.contains("الخط الثاني")) {
      return Color.fromARGB(255, 255, 0, 0); // Red
    } else if (lineName.contains("الخط الثالث")) {
      return Color.fromARGB(255, 0, 128, 0); // Green
    } else {
      return Color.fromARGB(255, 0, 0, 0); // Default Black
    }
  }

  // Load stations from a JSON file
  Future<void> loadStations() async {
    String data = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');
    stations = jsonDecode(data);
    for (var station in stations) {
      stationsname.add(station['name']);
    }
  }

  // Check if two stations are on the same line
  int? areStationsOnSameLine(String start, String end) {
    List<int> startLines = [];
    List<int> endLines = [];

    // العثور على الخطوط التي توجد بها المحطتين
    for (var station in stations) {
      if (station['name'] == start) {
        if (station['lines'] != null) {
          startLines = station['lines'].cast<int>();
        }
      }
      if (station['name'] == end) {
        if (station['lines'] != null) {
          endLines = station['lines'].cast<int>();
        }
      }
    }

    // التحقق من وجود خط مشترك بين المحطتين
    for (var line in startLines) {
      if (endLines.contains(line)) {
        return line; // إرجاع الخط المشترك
      }
    }

    return null; // إذا لم يكن هناك خط مشترك
  }

  void getStationsBetween(String start, String end) {
    routeStations1.clear();
    routeStations2.clear();
    isTransferStation = false;

    // تحديد الخط المشترك بين المحطتين
    int? commonLine = areStationsOnSameLine(start, end);

    // التحقق مما إذا كان هناك خط مشترك
    if (commonLine != null) {
      // إذا كان هناك خط مشترك، استخدمه لحساب المسار
      routeStations1 = getStationsBetweenSameLine(start, end, commonLine);
      return; // إنهاء الدالة هنا بدون البحث عن محطات تحويل
    }

    // إذا لم يكن هناك خط مشترك، نتابع البحث عن محطة تحويل
    String? transferStation;
    for (var station in stations) {
      if (station['name'] == start) startLine = station['line'];
      if (station['name'] == end) endLine = station['line'];
    }

    // البحث عن محطة تحويل بين الخطين
    for (var entry in transferStations.entries) {
      if (entry.value.contains(startLine) && entry.value.contains(endLine)) {
        transferStation = entry.key;
        break;
      }
    }

    if (transferStation != null) {
      isTransferStation = true;
      nameOftransferStation = transferStation;
      // حساب المسار بين البداية ومحطة التحويل
      routeStations1.addAll(getStationsBetweenSameLine(start, transferStation, startLine!));
      // حساب المسار بين النهاية ومحطة التحويل
      routeStations2.addAll(getStationsBetweenSameLine(end, transferStation, endLine!));
    }
  }


  // Get stations between two points on the same line
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
        }
      }
    }

    // Reverse the result if needed
    if (result[0] == endStation || result[0] == end) {
      result = result.reversed.toList();
    }

    return result;
  }
}