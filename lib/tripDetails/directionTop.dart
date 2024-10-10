import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DirectionTop extends StatelessWidget {
  const DirectionTop({super.key, required this.fromStation, required this.toStation});
  final String fromStation;
  final String toStation;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      color: Color.fromARGB(255, 2, 11, 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(toStation, style: TextStyle(color: Colors.white, fontSize: 32)),
          ),
          Icon(CupertinoIcons.arrow_left, color: Colors.white, size: 32),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(fromStation, style: TextStyle(color: Colors.white, fontSize: 32)),
          ),
        ],
      ),
    );
  }
}
