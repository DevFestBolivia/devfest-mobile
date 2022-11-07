import 'package:devfestbolivia/firebase/profile/profile_firestore.dart';
import 'package:devfestbolivia/firebase/profile/profile_repository_impl.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';
import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double _appBarElevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        extendBodyBehindAppBar: false,
        body: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.state == ProfileState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (profileProvider.state == ProfileState.loaded) {
              final profile = profileProvider.profile;

              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      floating: true,
                      backgroundColor: DevFestColors.primary,
                      elevation: _appBarElevation,
                      centerTitle: true,
                      title: Text(
                        TextStrings.profile.toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: DevFestColors.primaryLight,
                            ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: DevFestColors.primaryLight,
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Header(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpacingValues.m,
                            ),
                            child: _ProfileInfo(
                              profile: profile,
                            ),
                          )
                        ],
                      ),
                    )
                  ];
                },
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SpacingValues.m),
                  child: _Friends(
                    friends: profile.friends,
                  ),
                ),
              );
            }

            if (profileProvider.state == ProfileState.failure) {
              return const Center(
                child: Text(TextStrings.problemLoadingProfile),
              );
            }

            return Container();
          },
        ),
      );
    });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  final double _imageRadius = 60.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: DevFestColors.primary,
              height: _imageRadius * 1.5,
              width: double.infinity,
            ),
            SizedBox(
              height: _imageRadius,
            )
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              radius: _imageRadius,
              backgroundColor: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _bio(context),
        VerticalSpacing.l,
        _actions(context),
        const SizedBox(
          height: SpacingValues.m * 2,
        ),
        _score(context),
      ],
    );
  }

  Widget _bio(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                TextStrings.completeYourBio,
              )
            : Text(profile.bio),
      ],
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: QrImage(
                          data: profile.uid,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text(
            TextStrings.profileQR,
          ),
        ),
        if (profile.facebookUrl.isNotEmpty) ...[
          HorizontalSpacing.xxl,
          SvgPicture.asset('assets/svg/logo_facebook.svg'),
        ],
        if (profile.instagramUrl.isNotEmpty) ...[
          HorizontalSpacing.s,
          SvgPicture.asset('assets/svg/logo_instagram.svg'),
        ],
        if (profile.twitterUrl.isNotEmpty) ...[
          HorizontalSpacing.s,
          SvgPicture.asset('assets/svg/logo_twitter.svg'),
        ]
      ],
    );
  }

  Widget _score(BuildContext context) {
    const scoreElevation = 3.0;

    return Card(
      elevation: scoreElevation,
      child: SizedBox(
        width: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            // horizontal: SpacingValues.m * 2,
            vertical: SpacingValues.l,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/trophy.svg'),
              HorizontalSpacing.m,
              Text(
                'Score: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 24,
                      color: Color(0xff80868B),
                    ),
              ),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: profile.score.toInt()),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24,
                        ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Friends extends StatelessWidget {
  const _Friends({
    required this.friends,
  });

  final List<Friend> friends;

  final String _friendsLabel = 'Amigos';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StickyHeader(
      header: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        padding: const EdgeInsets.symmetric(
          vertical: SpacingValues.xs,
        ),
        child: Text(
          _friendsLabel,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      content: SizedBox(
        height: size.height - kToolbarHeight - SpacingValues.l,
        width: double.infinity,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingValues.xs,
          ),
          itemCount: friends.length,
          separatorBuilder: (context, index) => VerticalSpacing.xs,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return _FriendCard(
              friend: friend,
            );
          },
        ),
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({
    required this.friend,
  });

  final Friend friend;

  final double _elevation = 3.0;
  final double _imageRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingValues.m,
            vertical: SpacingValues.l,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  friend.imageUrl,
                ),
              ),
              HorizontalSpacing.m,
              Text(
                friend.fullName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
