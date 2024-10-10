import 'dart:convert';
import 'package:flutter/services.dart';


class MetroRouteFinder  {
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

  MetroRouteFinder(){
    loadStations();
  }
  // قراءة ملف JSON للمحطات
  Future<void> loadStations() async {
    String data = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');

    stations = jsonDecode(data);
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

        }
      }
    }
    if(result[0]==endStation){result= result.reversed.toList();result.removeAt(0);}


    return result;
  }


}
