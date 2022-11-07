import 'package:devfestbolivia/utils/speaker_util.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/firebase/speakers/speakers_repository.dart';
import 'package:devfestbolivia/firebase/speakers/speakers_repository_impl.dart';

import 'package:devfestbolivia/widgets/main_text.dart';

import 'package:devfestbolivia/models/session.dart';
import 'package:devfestbolivia/models/speaker.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class SessionCardDetail extends StatefulWidget {
  final Session session;

  const SessionCardDetail({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<SessionCardDetail> createState() => _SessionCardDetailState();
}

class _SessionCardDetailState extends State<SessionCardDetail> {
  SpeakersRepository? speakersRepository;
  bool loadingReference = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return loadingReference ? Container() : getDetail();
  }

  void loadReferences() {
    if (!loadingReference) {
      return;
    }

    speakersRepository = SpeakersRepositoryImpl();
    loadingReference = false;
  }

  Widget getDetail() {
    String? speakerId = SpeakerUtil.getSpeaker(widget.session);
    if (speakerId == null) {
      return renderDetail(null);
    }

    return FutureBuilder(
      future: speakersRepository!.getSpeakerById(speakerId),
      builder: (BuildContext context, AsyncSnapshot<Speaker> snapshot) {
        if (snapshot.hasData) {
          return renderDetail(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  Widget renderDetail(Speaker? speaker) {
    return Container(
      padding: const EdgeInsets.only(
        right: 2,
      ),
      child: Row(
        children: [
          renderSpeakerPhoto(speaker),
          const SizedBox(width: 10),
          renderTextDetail(speaker),
        ],
      ),
    );
  }

  Widget renderSpeakerPhoto(Speaker? speaker) {
    return speaker != null && speaker.photoUrl != null
        ? renderAvatar(speaker.photoUrl!)
        : renderIconAvatar();
  }

  Widget renderTextDetail(Speaker? speaker) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        renderTitle(),
        renderSpeakerName(speaker),
      ],
    );
  }

  Widget renderTitle() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: MainText(
        text: widget.session.title ?? '',
        colorText: DevFestColors.textBlack,
        fountWeight: FontWeight.w600,
        fontSize: FontSizeValues.input,
        // expandableText: true,
      ),
    );
  }

  Widget renderSpeakerName(Speaker? speaker) {
    return MainText(
      text: speaker != null && speaker.name != null ? speaker.name! : '',
      colorText: DevFestColors.labelInput,
      fountWeight: FontWeight.w400,
      fontSize: FontSizeValues.scheduleDetail,
    );
    
  }

  Widget renderAvatar(String photoUrl) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(photoUrl),
      backgroundColor: Colors.transparent,
    );
  }

  Widget renderIconAvatar() {
    return const Icon(
      Icons.account_circle_sharp,
      size: 60,
      color: DevFestColors.primary,
    );
  }
}
