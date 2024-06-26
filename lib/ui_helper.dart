import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  DataContainer({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 60.0, color: Colors.white),
        const SizedBox(height: 10.0),
        Text(title, style: textStyle1),
      ],
    );
  }
}

class ContainerBox extends StatelessWidget {
  ContainerBox({required this.boxColor, required this.childWidget});

  final Color boxColor;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: boxColor),
      child: childWidget,
    );
  }
}

const TextStyle textStyle1 = TextStyle(
  color: Color(0xFFffffff),
  letterSpacing: 0.8,
  fontSize: 25,
);

const TextStyle textStyle2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFFffffff),
    letterSpacing: 0.7,
    fontSize: 45);

const TextStyle textStyle3 = TextStyle(
    fontWeight: FontWeight.w500,
    color: Color(0xFFffffff),
    letterSpacing: 0.7,
    fontSize: 30);
