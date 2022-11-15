import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:devfestbolivia/providers/scanner_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ScannerTab extends StatefulWidget {
  const ScannerTab({super.key});

  @override
  State<ScannerTab> createState() => _ScannerTabState();
}

class _ScannerTabState extends State<ScannerTab> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScannerProvider>(
      create: (_) => ScannerProvider(
        profileProvider: profileProvider,
      ),
      child: const _ScannerBody(),
    );
  }
}

class _ScannerBody extends StatefulWidget {
  const _ScannerBody();

  @override
  State<_ScannerBody> createState() => __ScannerBodyState();
}

class __ScannerBodyState extends State<_ScannerBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Provider.of<ScannerProvider>(context, listen: false).reset();
        _scan();
      },
    );
  }

  void _scan() async {
    var status = await Permission.camera.status;
    bool granted = status.isGranted;
    if (!granted) {
      status = await Permission.camera.request();
      granted = status.isGranted;
    }

    if (granted) {
      // ignore: use_build_context_synchronously
      await Provider.of<ScannerProvider>(context, listen: false).scan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingValues.xxl,
            ),
            child: Consumer<ScannerProvider>(
              builder: (context, scannerProvider, child) {
                if (scannerProvider.state == ScannerState.scanResultInvalid) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('QR Inválido'),
                      VerticalSpacing.l,
                      ElevatedButton(
                        onPressed: () {
                          _scan();
                        },
                        child: Text('Escanear'.toUpperCase()),
                      ),
                    ],
                  ));
                }

                if (scannerProvider.state == ScannerState.scannedFriend) {
                  final friend = scannerProvider.friendResult!;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nuevo Contacto',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Conociste a:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        VerticalSpacing.xl,
                        friend.imageUrl.isEmpty
                            ? Container()
                            : SizedBox(
                                height: 160,
                                width: 160,
                                child: Image.network(
                                  friend.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        VerticalSpacing.l,
                        Text(
                          friend.fullName,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: DevFestColors.primary,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                if (scannerProvider.state == ScannerState.scannedDynamic) {
                  final dynamic = scannerProvider.dynamicResult!;

                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: LottieBuilder.asset('assets/lottie/trophy.json'),
                      ),
                      Text(
                        'Felicidades!!!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Conseguiste:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      VerticalSpacing.l,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpacingValues.m * 2,
                        ),
                        child: Text(
                          dynamic.value,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      VerticalSpacing.l,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Puntaje: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: DevFestColors.primary,
                                ),
                          ),
                          TweenAnimationBuilder<int>(
                            tween:
                                IntTween(begin: 0, end: dynamic.score.toInt()),
                            duration: const Duration(seconds: 2),
                            builder: (context, value, child) {
                              return Text(
                                '$value',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: DevFestColors.primary),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ));
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sin escanear aún'),
                      VerticalSpacing.m,
                      ElevatedButton(
                        onPressed: () {
                          _scan();
                        },
                        child: Text('Escanear'.toUpperCase()),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
