import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            renderProfileImage(),
          ],
        ),
      ),
    );
  }

  Widget renderProfileImage() {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _screenSize.width * 0.4,
      color: DevFestColors.primary,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1616169950073-8e1b0e2b0b1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
