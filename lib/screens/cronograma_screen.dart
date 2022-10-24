import 'package:devfestbolivia/constans.dart';
import 'package:devfestbolivia/widgets/cronograma_screen/card_cronograma.dart';
import 'package:flutter/material.dart';

class CronogramaScreen extends StatefulWidget {
  const CronogramaScreen({Key? key}) : super(key: key);

  @override
  State<CronogramaScreen> createState() => _CronogramaScreenState();
}

class _CronogramaScreenState extends State<CronogramaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "CRONOGRAMA",
            style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
            textAlign: TextAlign.end,
          ),
          bottom: TabBar(
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              labelColor: primaryColor,
              unselectedLabelColor: backgroundColor.withOpacity(0.74),
              indicator: const BoxDecoration(color: Colors.white),
              tabs: const [
                Tab(
                  text: "DÍA 1",
                ),
                Tab(
                  text: "DÍA 2",
                ),
              ]),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return CardCronograma(interval: (index == 3));
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return CardCronograma(interval: (index == 3));
              },
            ),
          ],
        ),
      ),
    );
  }
}
