import 'package:flutter/material.dart';

import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/date_util.dart';
import 'package:devfestbolivia/widgets/cards/main_cards.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/models/schedule.dart';

class TalksCard extends StatefulWidget {
  final Schedule schedule;
  final int index;
  final Function onPressed;

  const TalksCard({
    Key? key,
    required this.schedule,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<TalksCard> createState() => _TalksCardState();
}

class _TalksCardState extends State<TalksCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed(),
      child: MainCards(
        firstPart: renderFirstPart(),
        secondPart: renderDetail(),
      ),
    );
  }

  Widget renderFirstPart() {
    return SizedBox(
      width: 123,
      height: CardsSizeValues.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: DateUtil.getHourMinute(widget.schedule.date),
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.hour,
            fountWeight: FontWeight.w600,
          ),
          MainText(
            text: DateUtil.getAmPm(widget.schedule.date),
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.month,
            fountWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget renderDetail() {
    return Row(
      children: [
        renderAvatar(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainText(
              text: widget.schedule.tracks[widget.index].title ?? ' - ',
              colorText: DevFestColors.textBlack,
              fountWeight: FontWeight.w600,
              fontSize: FontSizeValues.input,
            ),
            MainText(
              text: widget.schedule.tracks[widget.index].speaker ?? ' - ',
              colorText: DevFestColors.labelInput,
              fountWeight: FontWeight.w600,
              fontSize: FontSizeValues.scheduleDetail,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderAvatar() {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 0),
      child: Image.network(
        widget.schedule.tracks[widget.index].speakerImage,
        width: 60,
        height: 60,
      ),
    );
  }
}
