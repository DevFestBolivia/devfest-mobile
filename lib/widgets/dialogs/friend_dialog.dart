import 'dart:math';

import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendDialog extends StatelessWidget {
  const FriendDialog({
    required this.profile,
    super.key,
  });

  final Profile profile;

  final double _imageRadius = 60.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SpacingValues.l,
            width: double.infinity,
            color: DevFestColors.primary,
          ),
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: _imageRadius,
                    color: DevFestColors.primary,
                  ),
                  Container(
                    height: _imageRadius,
                    color: DevFestColors.primaryLight,
                  )
                ],
              ),
              Center(
                child: profile.imageUrl.isEmpty
                    ? CircleAvatar(
                        radius: _imageRadius,
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length - 1)],
                        child: Center(
                          child: Text(
                            profile.fullName.characters.first,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SpacingValues.xxl * 2,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: _imageRadius,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          profile.imageUrl,
                        ),
                      ),
              ),
            ],
          ),
          VerticalSpacing.l,
          Text(
            profile.fullName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: DevFestColors.shadow,
          ),
          VerticalSpacing.xs,
          profile.bio.isEmpty
              ? const Text(
                  TextStrings.withoutBio,
                )
              : Text(profile.bio),
          VerticalSpacing.xxl,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (profile.facebookUrl.isNotEmpty) ...[
                HorizontalSpacing.s,
                GestureDetector(
                  onTap: () {
                    UrlLauncherUtils.openUrl(profile.facebookUrl);
                  },
                  child: SvgPicture.asset('assets/svg/logo_facebook.svg'),
                )
              ],
              if (profile.instagramUrl.isNotEmpty) ...[
                HorizontalSpacing.s,
                GestureDetector(
                  onTap: () {
                    UrlLauncherUtils.openUrl(profile.instagramUrl);
                  },
                  child: SvgPicture.asset('assets/svg/logo_instagram.svg'),
                )
              ],
              if (profile.twitterUrl.isNotEmpty) ...[
                HorizontalSpacing.s,
                GestureDetector(
                  onTap: () {
                    UrlLauncherUtils.openUrl(profile.twitterUrl);
                  },
                  child: SvgPicture.asset('assets/svg/logo_twitter.svg'),
                )
              ]
            ],
          ),
          VerticalSpacing.xxl,
        ],
      ),
    );
  }
}
