import 'package:flutter/material.dart';
import '../../Map/metro_route_finder.dart';
import '../constants.dart';

class FromToContainer extends StatefulWidget {
  final MetroRouteFinder routeFinder;

  FromToContainer({super.key, required this.routeFinder}); // إضافة الفاصلة هنا

  @override
  State<FromToContainer> createState() => _FromToContainerState();
}

class _FromToContainerState extends State<FromToContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // لون الظل مع الشفافية
            spreadRadius: 9, // مدى انتشار الظل
            blurRadius: 15, // مدى ضبابية الظل
            offset: Offset(0, 3), // إزاحة الظل (X:0, Y:3)
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _FromToField(
            label: 'من',
            hintText: "اختر محطة البداية",
            value: widget.routeFinder.startStation,
            onChanged: (newValue) {
              setState(() {
                widget.routeFinder.startStation = newValue;
              });
            },
            stations: widget.routeFinder.stationsname.toList(),
          ),
          SizedBox(height: 8),
          _FromToField(
            label: 'إلى',
            hintText: "اختر محطة الوصول",
            value: widget.routeFinder.endStation,
            onChanged: (newValue) {
              setState(() {
                widget.routeFinder.endStation = newValue;
              });
            },
            stations: widget.routeFinder.stationsname.toList(),
          ),
        ],
      ),
    );
  }
}

class _FromToField extends StatelessWidget {
  final String label;
  final String? value;
  final String hintText;
  final List<String> stations;
  final ValueChanged<String?>? onChanged;

  const _FromToField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.stations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.homeBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        hint: Text(hintText),
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        // اجعل القائمة المنسدلة تأخذ المساحة الكاملة
        underline: SizedBox(),
        // إزالة الخط السفلي
        icon: Padding(
          // إضافة padding للسهم
          padding: const EdgeInsets.only(left: 8.0), // مسافة من اليسار للسهم
          child: Icon(Icons.arrow_drop_down),
        ),
        // السهم هنا
        items: stations.map((station) {
          return DropdownMenuItem<String>(
            value: station,
            child: Text(station),
          );
        }).toList(),
      ),
    );
  }
}
