import 'package:flutter/material.dart';

class ContestsTab extends StatefulWidget {
  const ContestsTab({Key? key}) : super(key: key);

  @override
  State<ContestsTab> createState() => _ContestsTabState();
}

class _ContestsTabState extends State<ContestsTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Contests'),
      ),
    );
  }
}
