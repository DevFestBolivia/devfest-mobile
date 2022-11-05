import 'package:flutter/material.dart';

import 'package:devfestbolivia/firebase/speakers/speakers_repository.dart';
import 'package:devfestbolivia/firebase/speakers/speakers_repository_impl.dart';

import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/cards/main_cards.dart';
import 'package:devfestbolivia/widgets/cards/session_card_detail.dart';

import 'package:devfestbolivia/models/session.dart';

import 'package:devfestbolivia/utils/date_util.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class TalksCard extends StatefulWidget {
  final Session session;
  final String startTime;
  final String endTime;

  const TalksCard({
    Key? key,
    required this.session,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  State<TalksCard> createState() => _TalksCardState();
}

class _TalksCardState extends State<TalksCard> {
  SpeakersRepository? speakersRepository;
  bool loadingReference = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return !loadingReference ? renderTalkCard() : Container();
  }

  Widget renderTalkCard() {
    return MainCards(
      firstPart: renderFirstPart(),
      secondPart: SessionCardDetail(session: widget.session),
      widthFirstPart: 100,
    );
  }

  void loadReferences() {
    if (!loadingReference) {
      return;
    }

    speakersRepository = SpeakersRepositoryImpl();
    loadingReference = false;
  }

  Widget renderFirstPart() {
    return SizedBox(
      width: 50,
      height: CardsSizeValues.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: widget.startTime,
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.hour,
            fountWeight: FontWeight.w600,
          ),
          MainText(
            text: DateUtil.getAmPmToStringHourMinute(widget.startTime),
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.month,
            fountWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
