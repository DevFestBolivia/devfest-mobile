import 'package:flutter/material.dart';

class TimelineTab extends StatefulWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  State<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Timeline'),
      ),
    );
  }
}
