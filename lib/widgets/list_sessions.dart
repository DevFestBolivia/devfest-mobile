import 'package:flutter/material.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/models/session_item.dart';
import 'package:devfestbolivia/widgets/cards/session_card.dart';

class ListSession extends StatefulWidget {
  final Schedule? schedule;

  const ListSession({Key? key, required this.schedule}) : super(key: key);

  @override
  State<ListSession> createState() => _ListSessionState();
}

class _ListSessionState extends State<ListSession> {
  @override
  Widget build(BuildContext context) {
    return widget.schedule != null
        ? renderSessions(widget.schedule!)
        : Container();
  }

  Widget renderSessions(Schedule schedule) {
    List<SessionItem> sessions = getSessions(schedule);

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (BuildContext context, int index) {
        return SessionCard(
          startTime: sessions[index].startTime,
          endTime: sessions[index].endTime,
          sessionId: sessions[index].sessionId,
        );
      },
    );
  }

  List<SessionItem> getSessions(Schedule schedule) {
    List<SessionItem> sessions = [];
    for (var timeslot in schedule.timeslots) {
      for (var session in timeslot.sessions) {
        SessionItem sessionItem = SessionItem(
          startTime: timeslot.startTime,
          endTime: timeslot.endTime,
          sessionId: session.items[0],
        );
        sessions.add(sessionItem);
      }
    }

    return sessions;
  }
}
