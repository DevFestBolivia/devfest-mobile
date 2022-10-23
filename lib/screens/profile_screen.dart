import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final double _appBarElevation = 0.0;

  final String _appBarTitle = 'PERFIL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              backgroundColor: DevFestColors.primary,
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
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingValues.m,
                    ),
                    child: _ProfileInfo(),
                  )
                ],
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpacingValues.m),
          child: _Friends(),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: DevFestColors.primary,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingValues.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileInfo(),
                  SizedBox(
                    height: SpacingValues.xxl,
                  ),
                  _Friends(),
                ],
              ),
            )
          ],
        ),
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
        Container(
          height: 1,
          width: double.infinity,
          color: DevFestColors.divider,
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

class _Friends extends StatelessWidget {
  const _Friends();

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
          itemCount: 10,
          separatorBuilder: (context, index) => VerticalSpacing.xs,
          itemBuilder: (context, index) {
            return _FriendCard(name: 'Dalma Oropesa Argandolla');
          },
        ),
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({required this.name});

  final String name;

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
                radius: _imageRadius,
              ),
              HorizontalSpacing.m,
              Text(
                name,
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
