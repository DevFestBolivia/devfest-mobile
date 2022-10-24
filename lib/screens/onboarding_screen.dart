import 'package:devfestbolivia/providers/onboarding_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _OnboardingItem {
  const _OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late List<_OnboardingItem> onboardingItems;

  final OnboardingProvider onboardingProvider = OnboardingProvider();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    onboardingItems = const [
      _OnboardingItem(
        imagePath: 'assets/images/onboarding-step-1.png',
        title: 'Acumula puntos',
        description:
            'Tendremos muchas actividades de las que podras participar para ganar puntos y poder reclamar premios!\n\nEncontraras tus puntos acumulados en la información de tu perfil.',
      ),
      _OnboardingItem(
        imagePath: 'assets/images/onboarding-step-2.png',
        title: 'Agrega nuevos amigos',
        description:
            'Encuentra el código QR en tu perfil para que puedan agregarte como amigo en la aplicación.\n\nUsa el scanner QR para agregar a tus nuevos amigos.',
      ),
      _OnboardingItem(
        imagePath: 'assets/images/onboarding-step-3.png',
        title: 'Descarga recursos',
        description:
            'Los speakers dejarán contenido adicional en la aplicación dentro del detalle de sus charlas.\n\nRevisa y descubre todos los recursos disponibles de cada charla.',
      ),
    ];

    _pageController.addListener(_changePage);
  }

  @override
  void dispose() {
    _pageController.removeListener(_changePage);
    _pageController.dispose();
    super.dispose();
  }

  void _changePage() {
    onboardingProvider.changePage(_pageController.page?.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>.value(
      value: onboardingProvider,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Consumer<OnboardingProvider>(
            builder: (context, onboardingProvider, child) {
              final isLastOnboardingPage =
                  onboardingProvider.pageIndex == onboardingItems.length - 1;

              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 700,
                ),
                child: isLastOnboardingPage
                    ? _startOnboardingButton()
                    : _omitOnboardingButton(),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingValues.m,
            vertical: SpacingValues.xxl,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingItems.length,
                  itemBuilder: (context, index) {
                    final oItem = onboardingItems[index];
                    return _StepOnboardingCard(onboardingItem: oItem);
                  },
                ),
              ),
              VerticalSpacing.m,
              const _DotsIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _startOnboardingButton() {
    return ElevatedButton(
      key: const ValueKey('start__elevated_button'),
      onPressed: () {},
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(DevFestColors.primary),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: DevFestColors.primary,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SpacingValues.m),
          child: Text(
            'EMPEZAR',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _omitOnboardingButton() {
    return ElevatedButton(
      key: const ValueKey('omit__elevated_button'),
      onPressed: () {},
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(DevFestColors.primaryLight),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: DevFestColors.primary,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SpacingValues.m),
          child: Text(
            'OMITIR',
            style: TextStyle(
              color: DevFestColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _StepOnboardingCard extends StatelessWidget {
  const _StepOnboardingCard({required this.onboardingItem});

  final _OnboardingItem onboardingItem;

  final _stepCardElevation = 3.0;
  final _stepImageSize = 280.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _stepCardElevation,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingValues.s,
              ),
              child: Center(
                child: SizedBox(
                  height: _stepImageSize,
                  width: _stepImageSize,
                  child: Image.asset(onboardingItem.imagePath),
                ),
              ),
            ),
            VerticalSpacing.l,
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingValues.m,
                right: SpacingValues.m,
                bottom: SpacingValues.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    onboardingItem.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  VerticalSpacing.xxs,
                  Text(
                    onboardingItem.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator();

  final _dotIndicatorSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _animatedDot(0),
        HorizontalSpacing.m,
        _animatedDot(1),
        HorizontalSpacing.m,
        _animatedDot(2),
      ],
    );
  }

  Widget _animatedDot(int pageIndex) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          height: _dotIndicatorSize,
          width: _dotIndicatorSize,
          decoration: BoxDecoration(
            color: onboardingProvider.pageIndex == pageIndex
                ? DevFestColors.primary
                : DevFestColors.shadow,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
