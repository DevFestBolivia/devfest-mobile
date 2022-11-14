import 'package:devfestbolivia/widgets/section_divider.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/models/session.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

import 'package:devfestbolivia/utils/date_util.dart';

import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/speaker_info.dart';

import 'package:devfestbolivia/text_strings.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String? startTime;
  final String? endTime;
  final Session? session;

  const TaskDetailsScreen({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.session,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              VerticalSpacing.l,
              renderTitle(),
              VerticalSpacing.xs,
              renderStartTime(),
              VerticalSpacing.xs,
              renderDetail(),
              const SizedBox(height: 30),
              _renderTitleSpeaker(),
              const SectionDivider(height: 10, indent: 20),
              renderSpeakerInfo(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget renderAppBar() {
    return AppBar(
      centerTitle: true,
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

  Widget renderTitle() {
    return MainText(
      text: widget.session!.title!,
      colorText: DevFestColors.textBlack,
      fontSize: 20,
      fountWeight: FontWeightValues.semiBold,
      leftMargin: SpacingValues.xxl,
      rightMargin: SpacingValues.xxl,
    );
  }

  Widget renderStartTime() {
    return MainText(
      text:
          '${widget.startTime!} ${DateUtil.getAmPmToStringHourMinute(widget.startTime!)}',
      colorText: DevFestColors.primary,
      fontSize: 16,
      fountWeight: FontWeightValues.regular,
    );
  }

  Widget renderDetail() {
    return MainText(
      text: widget.session!.description!,
      colorText: DevFestColors.textBlack,
      fontSize: FontSizeValues.input,
      fountWeight: FontWeightValues.normal,
      leftMargin: SpacingValues.xxl,
      rightMargin: SpacingValues.xxl,
    );
  }

  Widget renderSpeakerInfo() {
    if (widget.session == null ||
        widget.session!.speakers == null ||
        widget.session!.speakers!.isEmpty) {
      return Container();
    }

    return SpeakerInfo(speakerId: widget.session!.speakers!.first);
  }

  Widget _renderTitleSpeaker() {
    return Container(
      color: DevFestColors.primaryLight,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: SpacingValues.xxl,
        right: SpacingValues.xxl,
      ),
      child: MainText(
        text: TextStrings.speaker,
        fountWeight: FontWeightValues.bold,
        colorText: DevFestColors.textBlack,
      ),
    );
  }
}
