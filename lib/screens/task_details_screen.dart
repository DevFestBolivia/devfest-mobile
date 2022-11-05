import 'package:devfestbolivia/models/session.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Session? session;

  const TaskDetailsScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print('Schedule: ${widget.session}');
    return Scaffold(
      appBar: renderAppBar(),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  PreferredSizeWidget renderAppBar() {
    return AppBar(
      title: Text(
        TextStrings.details.toUpperCase(),
        style: const TextStyle(
          color: DevFestColors.textBlack,
        ),
      ),
      iconTheme: const IconThemeData(
        color: DevFestColors.textBlack,
      ),
      backgroundColor: DevFestColors.primaryLight,
      shadowColor: DevFestColors.transparent,
    );
  }
}
