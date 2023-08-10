import 'package:fl_pip/fl_pip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_waya/components/count_down.dart';
import 'package:flutter_waya/flutter_waya.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
          child: PiPBuilder(
              pip: FlPiP(),
              builder: (PiPStatus status) {
                switch (status) {
                  case PiPStatus.enabled:
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      CountDown(
                          onChanged: (int i) {},
                          periodic: 1,
                          duration: const Duration(seconds: 500),
                          builder: (int i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              child: Text(i.toString()))),
                      const Text('PiPStatus enabled'),
                    ]);
                  case PiPStatus.disabled:
                    return builderDisabled;
                  case PiPStatus.unavailable:
                    return buildUnavailable;
                }
              })));

  Widget get builderDisabled =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('PiPStatus disabled'),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              FlPiP().enable(
                  ios: const FlPiPiOSConfig(
                      path: 'assets/landscape.mp4', packageName: null),
                  android: const FlPiPAndroidConfig(
                      aspectRatio: Rational.maxLandscape()));
            },
            child: const Text('Enable PiP')),
        ElevatedButton(
            onPressed: () {
              FlPiP().enableWithEngine(
                  engine: FlPiPEngineConfig(
                      mainName: 'pipMain', whenStopDestroyEngine: false));
            },
            child: const Text('Enable PiP with Engine')),
      ]);

  Widget get buildUnavailable => ElevatedButton(
      onPressed: () async {
        final state = await FlPiP().isAvailable;
        if (!mounted) return;
        if (!state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('PiP unavailable')));
        }
      },
      child: const Text('PiP unavailable'));
}

class PiPMainApp extends StatelessWidget {
  const PiPMainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        CountDown(
            onChanged: (int i) {},
            periodic: 1,
            duration: const Duration(seconds: 500),
            builder: (int i) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Text(i.toString()))),
        const Text('pip is currently enabled using mainName'),
        ElevatedButton(
            onPressed: () async {
              final state = await FlPiP().isAvailable;
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: state
                        ? const Text('PiP available')
                        : const Text('PiP unavailable')));
              }
            },
            child: const Text('PiPStatus enabled')),
      ])));
}