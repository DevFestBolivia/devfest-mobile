import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:devfestbolivia/models/social_link.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/widgets/main_text.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/models/speaker.dart';

import 'package:devfestbolivia/firebase/speakers/speakers_repository.dart';
import 'package:devfestbolivia/firebase/speakers/speakers_repository_impl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SpeakerInfo extends StatefulWidget {
  final String speakerId;

  const SpeakerInfo({Key? key, required this.speakerId}) : super(key: key);

  @override
  State<SpeakerInfo> createState() => _SpeakerInfoState();
}

class _SpeakerInfoState extends State<SpeakerInfo> {
  SpeakersRepository? speakersRepository;
  bool loadingReferences = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();
    if (speakersRepository == null) {
      return Container();
    }

    return Container(
      // width: 200,
      margin: const EdgeInsets.only(
        left: SpacingValues.xxl,
        right: SpacingValues.xxl,
      ),
      child: renderFutureSpeaker(widget.speakerId),
    );
  }

  void loadReferences() {
    if (!loadingReferences) {
      return;
    }
    speakersRepository = SpeakersRepositoryImpl();
    loadingReferences = false;
    setState(() {});
  }

  Widget renderFutureSpeaker(String speakerId) {
    if (speakersRepository == null) {
      return Container();
    }

    return FutureBuilder(
      future: speakersRepository!.getSpeakerById(speakerId),
      builder: (BuildContext context, AsyncSnapshot<Speaker?> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return _renderSpeaker(snapshot.data!);
        }
      },
    );
  }

  Widget _renderSpeaker(Speaker? speaker) {
    if (speaker == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing.xxs,
        renderTitleSpeaker(speaker),
        VerticalSpacing.xs,
        renderBio(speaker),
        VerticalSpacing.xl,
        renderSocialLinks(speaker),
      ],
    );
  }

  Widget renderTitleSpeaker(Speaker? speaker) {
    return Row(
      children: [
        renderAvatar(speaker!.photoUrl ?? ''),
        HorizontalSpacing.l,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: speaker.name ?? '',
                fontSize: FontSizeValues.input,
                colorText: DevFestColors.primary,
              ),
              Text(
                speaker.title ?? '',
                style: TextStyle(
                  fontSize: FontSizeValues.input,
                  color: DevFestColors.labelInput,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget renderBio(Speaker? speaker) {
    return MainText(
      text: speaker!.bio ?? '',
      colorText: DevFestColors.textBlack,
    );
  }

  Widget renderAvatar(String photoUrl) {
    if (photoUrl.isEmpty) return Container();

    return CircleAvatar(
      radius: 20.0,
      backgroundImage: NetworkImage(photoUrl),
      backgroundColor: Colors.transparent,
    );
  }

  Widget renderSocialLinks(Speaker? speaker) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (SocialLink social in speaker!.socials!)
              renderSocialLink(social),
          ],
        ),
      ),
    );
  }

  Widget renderSocialLink(
    SocialLink socialLink,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: InkWell(
        onTap: () => _launchUrl(socialLink.link),
        child: SizedBox(
          height: SpacingValues.xl * 2,
          width: SpacingValues.xl * 2,
          child: getSocialIcon(socialLink),
        ),
      ),
    );
  }

  Widget getSocialIcon(SocialLink socialLink) {
    if (socialLink.icon == 'facebook') {
      return SvgPicture.asset('assets/svg/logo_facebook.svg');
    }
    if (socialLink.icon == 'twitter') {
      return SvgPicture.asset('assets/svg/logo_twitter.svg');
    }
    if (socialLink.icon == 'instagram') {
      return SvgPicture.asset('assets/svg/logo_instagram.svg');
    }
    return Container();
  }

  Future<void> _launchUrl(String stringUrl) async {
    final Uri url = Uri.parse(stringUrl);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
