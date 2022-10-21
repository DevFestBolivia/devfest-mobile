import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final double _appBarElevation = 0.0;

  final String _appBarTitle = 'PERFIL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: _appBarElevation,
        centerTitle: true,
        title: Text(
          _appBarTitle,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(SpacingValues.m),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ProfileInfo(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
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
              height: _imageRadius * 2.5,
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
              backgroundImage:
                  const AssetImage('assets/images/dummy_profile.png'),
            ),
          ),
        )
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();

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
    final dummyName = 'Tatiana Arcand';
    final dummyBio =
        'Ingeniera en Software, GDE en Google Assistant, desarrolladore Full Stack en IBM, he trabajado en varios proyectos muy conocidos como Netflix, Watson, Google Pay, entre otros.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dummyName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        VerticalSpacing.xs,
        Text(dummyBio),
      ],
    );
  }

  Widget _actions(BuildContext context) {
    final profileQRLabel = 'QR DE PERFIL';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text(
            profileQRLabel,
          ),
        ),
        HorizontalSpacing.xxl,
        SvgPicture.asset('assets/svg/logo_facebook.svg'),
        HorizontalSpacing.s,
        SvgPicture.asset('assets/svg/logo_instagram.svg'),
        HorizontalSpacing.s,
        SvgPicture.asset('assets/svg/logo_twitter.svg'),
      ],
    );
  }

  Widget _score(BuildContext context) {
    final _scoreElevation = 3.0;
    final scoreValue = 1090;
    return Card(
      elevation: _scoreElevation,
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
                tween: IntTween(begin: 0, end: scoreValue),
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
