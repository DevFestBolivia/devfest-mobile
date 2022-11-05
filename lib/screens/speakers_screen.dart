import 'package:flutter/material.dart';

import 'package:devfestbolivia/models/speaker.dart';
import 'package:devfestbolivia/firebase/speakers/speakers_repository_impl.dart';
import 'package:devfestbolivia/firebase/speakers/speakers_repository.dart';

class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({Key? key}) : super(key: key);

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
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
