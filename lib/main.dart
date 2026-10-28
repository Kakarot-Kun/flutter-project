
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChronometreApp());
}

class ChronometreApp extends StatelessWidget {
  const ChronometreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronomètre Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ChronometrePage(),
    );
  }
}

class ChronometrePage extends StatefulWidget {
  const ChronometrePage({super.key});

  @override
  State<ChronometrePage> createState() =>
      _ChronometrePageState();
}

class _ChronometrePageState extends State<ChronometrePage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _demarrerOuPause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(
        const Duration(milliseconds: 30),
        (_) {
          if (mounted) {
            setState(() {});
          }
        },
      );
    }

    setState(() {});
  }

  void _reinitialiser() {
    _timer?.cancel();
    _stopwatch
      ..stop()
      ..reset();
    setState(() {});
  }

  String _formaterTemps(Duration duree) {
    final minutes =
        duree.inMinutes.toString().padLeft(2, '0');
    final secondes =
        (duree.inSeconds % 60).toString().padLeft(2, '0');
    final centiemes =
        ((duree.inMilliseconds % 1000) ~/ 10)
            .toString()
            .padLeft(2, '0');

    return '$minutes:$secondes:$centiemes';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enCours = _stopwatch.isRunning;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Chronomètre'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer_outlined,
              size: 90,
              color: Colors.blue,
            ),
            const SizedBox(height: 30),
            Text(
              _formaterTemps(_stopwatch.elapsed),
              style: const TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                fontFeatures: [
                  FontFeature.tabularFigures(),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _demarrerOuPause,
                  icon: Icon(
                    enCours ? Icons.pause : Icons.play_arrow,
                  ),
                  label: Text(
                    enCours
                        ? 'Pause'
                        : _stopwatch.elapsed == Duration.zero
                            ? 'Démarrer'
                            : 'Reprendre',
                  ),
                ),
                const SizedBox(width: 15),
                OutlinedButton.icon(
                  onPressed: _reinitialiser,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réinitialiser'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
