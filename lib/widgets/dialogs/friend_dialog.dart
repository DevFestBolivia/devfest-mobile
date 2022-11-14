import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:flutter/material.dart';

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
                child: CircleAvatar(
                  radius: _imageRadius,
                  backgroundImage: const NetworkImage(
                    'https://scontent.flpb3-1.fna.fbcdn.net/v/t1.6435-9/182753394_489192202130262_3036116466289640921_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=9EjFNCCKSp8AX_N62GD&tn=jAzwOIEn4qSkZS3L&_nc_ht=scontent.flpb3-1.fna&oh=00_AfBuwpS-u5eNYkJ4ZJ0lmf_LsuNJKIhS8UfGHacHh9ZUGg&oe=63913F53',
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
        ],
      ),
    );
  }
}
