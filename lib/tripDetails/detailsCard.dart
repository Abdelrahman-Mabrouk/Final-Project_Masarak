import 'dart:ffi';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.textDesc, required this.iconDesc, required this.classDetail, required this.classNum});
  final String textDesc;
  final IconData iconDesc;
  final String classDetail;
  final String classNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 145,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(textDesc, style: TextStyle(color: Colors.grey, fontSize: 27)),
              Icon(iconDesc, color: Colors.grey, size: 40),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(classDetail, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              Text(classNum, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
