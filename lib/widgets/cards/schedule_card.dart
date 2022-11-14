import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/date_util.dart';
import 'package:devfestbolivia/widgets/cards/main_cards.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;
  final int index;
  final Function onPressed;

  const ScheduleCard({
    Key? key,
    required this.schedule,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
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
            text: DateUtil.getDayNumber(widget.schedule.date),
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.day,
            fountWeight: FontWeight.w600,
          ),
          MainText(
            text: DateUtil.getMinimalNameMonth(widget.schedule.date),
            colorText: DevFestColors.primary,
            fontSize: CardsSizeValues.month,
            fountWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget renderDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MainText(
          text: '${TextStrings.day} ${widget.index + 1}',
          colorText: DevFestColors.textBlack,
          fountWeight: FontWeight.w600,
          fontSize: FontSizeValues.input,
        ),
        MainText(
          text: widget.schedule.description,
          colorText: DevFestColors.labelInput,
          fountWeight: FontWeight.w600,
          fontSize: FontSizeValues.scheduleDetail,
        ),
      ],
    );
  }
}
