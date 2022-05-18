import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class statPage extends StatelessWidget {
  Map<String, double> dataMap = {
    "Ariana":10,
    "Nabeul": 18.47,
    "Tunis": 17.70,
    "Mahdia": 3.25,
    "Bizert": 3.51,
    "Beja": 1.83,
    "Tozeur": 18.47,
    "Sousse": 17.70,
    "Gafsa": 4.25,
    "Gbelli": 3.51,
    "Mednine": 8.83,
    "Beja" : 10,
    "Ben Arous" :10,
    "Gabes" : 11,
    "jendouba":1,
    "Kef":2,


  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ],
    [
    const Color.fromRGBO(200, 50, 205, 1),
    const Color.fromRGBO(150, 70, 199, 1),
  ],

  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Statistiques'),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: Center(
    child: PieChart(
    dataMap: dataMap,
    colorList: colorList,
    chartRadius: MediaQuery.of(context).size.width / 2,
    centerText: "Budget",
    ringStrokeWidth: 24,
    animationDuration: const Duration(seconds: 3),
    chartValuesOptions: const ChartValuesOptions(
    showChartValues: true,
    showChartValuesOutside: true,
    showChartValuesInPercentage: true,
    showChartValueBackground: false),
    legendOptions: const LegendOptions(
    showLegends: true,
    legendShape: BoxShape.rectangle,
    legendTextStyle: TextStyle(fontSize: 15),
    legendPosition: LegendPosition.bottom,
    showLegendsInRow: true),
    gradientList: gradientList,
    ),
    ),
    );

  }




