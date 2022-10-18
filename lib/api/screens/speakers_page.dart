import 'package:flutter/material.dart';

import 'package:devfestbolivia/api/speakers/fb_speakers.dart';
import 'package:devfestbolivia/api/speakers/speakers_repository.dart';
import 'package:devfestbolivia/models/speaker.dart';


class SpeakersPage extends StatefulWidget {
  const SpeakersPage({Key? key}) : super(key: key);

  @override
  State<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  SpeakersRepository? speakersRepository;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      loadingReferences();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Speakers'),
      ),
      body: Center(
        child: loading ? const CircularProgressIndicator() : renderSpeakers(),
      ),
    );
  }

  Widget renderSpeakers() {
    return Center(
      child: StreamBuilder(
        stream: speakersRepository?.getAllSpeakers(),
        builder: (BuildContext context, AsyncSnapshot<List<Speaker>> snapshot) {
          return _listSpeakers(snapshot.data, context);
        },
      ),
    );
  }

  Widget _listSpeakers(List<Speaker>? speakers, BuildContext context) {
    if (speakers != null) {
      return ListView(
        children: speakers
            .asMap()
            .map((key, value) => MapEntry(key, speakerItem(value)))
            .values
            .toList(),
      );
    }
    return const CircularProgressIndicator();
  }

  Widget speakerItem(Speaker? speaker) {
    return Card(
      child: ListTile(
        title: Text(speaker!.title!),
      ),
    );
  }

  void loadingReferences() {
    speakersRepository = SpeakersRepositoryImpl();
    loading = false;
  }

  void getSpeakers() {}
}
