import 'package:devfestbolivia/models/session.dart';
import 'package:devfestbolivia/screens/task_details_screen.dart';
import 'package:devfestbolivia/widgets/cards/talks_card.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/firebase/sessions/sessions_repository.dart';
import 'package:devfestbolivia/firebase/sessions/sessions_repository_impl.dart';

class SessionCard extends StatefulWidget {
  final String startTime;
  final String endTime;
  final String? sessionId;

  const SessionCard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.sessionId,
  }) : super(key: key);

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  SessionsRepository? sessionsRepository;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return widget.sessionId != null ? renderSession() : Container();
  }

  Widget renderSession() {
    return FutureBuilder(
      future: sessionsRepository!.getSessionById(widget.sessionId!),
      builder: (BuildContext context, AsyncSnapshot<Session> snapshot) {
        if (snapshot.hasData) {
          return renderSessionCard(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  Widget renderSessionCard(Session session) {
    return InkWell(
      onTap: () => goToDetail(session),
      child: TalksCard(
        session: session,
        startTime: widget.startTime,
        endTime: widget.endTime,
      ),
    );
  }

  void loadReferences() {
    if (!loading) {
      return;
    }

    sessionsRepository = SessionsRepositoryImpl();
    loading = false;
  }

  void goToDetail(Session? session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(session: session),
      ),
    );
  }
}
