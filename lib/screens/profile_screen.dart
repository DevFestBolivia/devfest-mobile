import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';
import 'package:devfestbolivia/models/avatar.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/url_launcher_utils.dart';
import 'package:devfestbolivia/widgets/dialogs/error_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/friend_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return FutureBuilder(
          future: Connectivity().checkConnectivity(),
          builder: (context, snapshot) {
            bool hasInternet = true;

            if (snapshot.hasData) {
              hasInternet = snapshot.data! != ConnectivityResult.none;
            }

            if (hasInternet == false) {
              return Padding(
                padding: const EdgeInsets.all(SpacingValues.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 160,
                      child:
                          LottieBuilder.asset('assets/lottie/no-internet.json'),
                    ),
                    Text(
                      TextStrings.checkYourConnectivity,
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    VerticalSpacing.m,
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text(TextStrings.retry),
                    ),
                  ],
                ),
              );
            }

            return SafeArea(
              child: Scaffold(
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

                      return RefreshIndicator(
                        notificationPredicate: (notification) {
                          return notification.depth == 0;
                        },
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 5));
                        },
                        child: NestedScrollView(
                          headerSliverBuilder: (context, isScrolled) {
                            return <Widget>[
                              SliverToBoxAdapter(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Stack(
                                      alignment: const Alignment(0, -0.95),
                                      children: [
                                        _Header(
                                          profile: profile,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.3),
                                                shape: const CircleBorder(),
                                              ),
                                              onPressed: () {
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .initProfile();
                                              },
                                              child: const Icon(
                                                Icons.refresh,
                                                color:
                                                    DevFestColors.primaryLight,
                                                size: 32,
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.3),
                                                shape: const CircleBorder(),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.EDIT_PROFILE,
                                                  arguments: {
                                                    'profileProvider':
                                                        profileProvider,
                                                    'onEditProfileDone':
                                                        profileProvider
                                                            .initProfile,
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit_outlined,
                                                color:
                                                    DevFestColors.primaryLight,
                                                size: 32,
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.3),
                                                shape: const CircleBorder(),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const _ModalConfirm();
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.logout,
                                                color:
                                                    DevFestColors.primaryLight,
                                                size: 32,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: SpacingValues.m),
                            child: _Friends(
                              friends: profile.friends,
                            ),
                          ),
                        ),
                      );
                    }

                    if (profileProvider.state == ProfileState.failure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(TextStrings.problemLoadingProfile),
                            VerticalSpacing.l,
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<ProfileProvider>(context,
                                        listen: false)
                                    .initProfile();
                              },
                              child: const Text('Reintentar'),
                            )
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ModalConfirm extends StatelessWidget {
  const _ModalConfirm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        TextStrings.logoutConfirmationQuestion,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(TextStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            final fbUserRepository = FbUserRepositoryImpl();
            fbUserRepository.logout();
            Navigator.pushReplacementNamed(
              context,
              Routes.LOGIN,
            );
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.profile,
  });

  final double _imageRadius = 60.0;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: DevFestColors.primary,
              // height: _imageRadius * 1.5,
              width: double.infinity,
              child: Image.asset(
                Avatar.background,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: _imageRadius,
            )
          ],
        ),
        Positioned.fill(
          child: (profile.avatar == 0)
              ? Align(
                  alignment: Alignment.bottomCenter,
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
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    Avatar.getAvatart(profile.avatar).path,
                    width: 120,
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
    );
  }

  Widget _score(BuildContext context) {
    const scoreElevation = 3.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.TROPHIES,
          arguments: profile,
        );
      },
      child: Card(
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
                        color: const Color(0xff80868B),
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
          '$_friendsLabel (${friends.length})',
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
            return GestureDetector(
              onTap: () async {
                try {
                  Dialogs.showLoadingDialog(context);
                  final profile =
                      await Provider.of<ProfileProvider>(context, listen: false)
                          .getProfileById('1936x2pmw4ZqWy2baFXQFm1fTZB3');
                  // ignore: use_build_context_synchronously
                  Dialogs.hideLoadingDialog(context);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return FriendDialog(
                        profile: profile,
                      );
                    },
                  );
                } catch (e) {
                  Dialogs.hideLoadingDialog(context);
                  ErrorDialog.showErrorDialog(context,
                      'No se puede mostrar el perfil de ${friend.fullName} en este momento.');
                }
              },
              child: _FriendCard(
                friend: friend,
              ),
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

  // final double _elevation = 3.0;
  // final double _imageRadius = 20.0;

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
              friend.imageUrl.isEmpty
                  ? CircleAvatar(
                      backgroundColor: Colors.primaries[
                          Random().nextInt(Colors.primaries.length - 1)],
                      child: Center(
                        child: Text(
                          friend.fullName.characters.first,
                        ),
                      ),
                    )
                  : CircleAvatar(
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
