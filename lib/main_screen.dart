import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

const primaryColor = Color(0xff3F64F4);
const greyColor = Color(0xFF212121);

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color maleBoxColor = primaryColor;
  Color femaleBoxColor = greyColor;
  int height = 180;
  int weight = 40;
  int age = 18;
  String result = "";
  String resultDetail = "Result here";
  double bmi = 0;

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == greyColor) {
        maleBoxColor = primaryColor;
        femaleBoxColor = greyColor;
      } else {
        maleBoxColor = greyColor;
        femaleBoxColor = primaryColor;
      }
    } else {
      if (femaleBoxColor == greyColor) {
        femaleBoxColor = primaryColor;
        maleBoxColor = greyColor;
      } else {
        femaleBoxColor = greyColor;
        maleBoxColor = primaryColor;
      }
    }
  }

  String calculateBmi(int weight, int height) {
    double bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  String getInterpretation(double bmi) {
    if (bmi >= 25.0) {
      return 'You have higher than normal body weight. Try to excersie more.';
    } else if (bmi > 18.5) {
      return 'You have a normal body weight. Good Job!';
    } else {
      return 'You have lower than normal body weight. You can eat a bit more.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: FittedBox(
            child: const Text("BMI Calculator",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500)),
          )),
      body: Column(
        children: <Widget>[
          /// first section
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateBoxColor(1);
                    });
                  },
                  child: ContainerBox(
                    boxColor: maleBoxColor,
                    childWidget: DataContainer(
                        icon: FontAwesomeIcons.male, title: 'MALE'),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateBoxColor(2);
                    });
                  },
                  child: ContainerBox(
                    boxColor: femaleBoxColor,
                    childWidget: DataContainer(
                        icon: FontAwesomeIcons.female, title: 'FEMALE'),
                  ),
                ),
              ),
            ],
          )),

          /// second section
          Expanded(
            child: ContainerBox(
              boxColor: greyColor,
              childWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(child: const Text('HEIGHT', style: textStyle1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      FittedBox(
                          child: Text(height.toString(), style: textStyle2)),
                      const Text('cm', style: textStyle1),
                    ],
                  ),
                  Slider(
                    min: 120,
                    max: 220,
                    value: height.toDouble(),
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  )
                ],
              ),
            ),
          ),

          /// third section
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ContainerBox(
                  boxColor: greyColor,
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(child: const Text('WEIGHT', style: textStyle1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          FittedBox(
                              child:
                                  Text(weight.toString(), style: textStyle2)),
                          const Text(
                            'kg',
                            style: textStyle1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (weight > 0) {
                                  weight--;
                                }
                              });
                            },
                            backgroundColor: primaryColor,
                            child: const Icon(FontAwesomeIcons.minus,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 21),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            backgroundColor: primaryColor,
                            child: const Icon(FontAwesomeIcons.plus,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ContainerBox(
                boxColor: greyColor,
                childWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(child: const Text('AGE', style: textStyle1)),
                    FittedBox(child: Text(age.toString(), style: textStyle2)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (age > 0) {
                                age--;
                              }
                            });
                          },
                          backgroundColor: primaryColor,
                          child: const Icon(FontAwesomeIcons.minus,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 21),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (age < 100) {
                                age++;
                              }
                            });
                          },
                          backgroundColor: primaryColor,
                          child: const Icon(FontAwesomeIcons.plus,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ],
          )),
          GestureDetector(
              onTap: () {
                setState(() {
                  result = calculateBmi(weight, height);
                  resultDetail = getInterpretation(bmi);

                  showDialog(
                      context: context,
                      builder: (BuildContext contest) {
                        return Dialog(
                            backgroundColor: greyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              color: greyColor,
                              height: 250,
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                      child: const Text('Your BMI',
                                          style: textStyle1)),
                                  FittedBox(
                                      child: Text(result.toString(),
                                          style: textStyle2)),
                                  Center(
                                      child: FittedBox(
                                    child: Text(resultDetail,
                                        textAlign: TextAlign.center,
                                        style: textStyle1),
                                  )),
                                ],
                              ),
                            ));
                      });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 60.0,
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        topRight: Radius.circular(21))),
                child: const Center(
                  child: Text(
                    'Calculate',
                    style: textStyle3,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
