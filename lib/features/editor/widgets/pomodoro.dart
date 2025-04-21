import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PomodoroTimer extends StatefulWidget {
  final Duration duration;

  const PomodoroTimer({super.key, required this.duration});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late Timer _timer;
  late int _totalSeconds;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.duration.inSeconds;
    _remainingSeconds = _totalSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final percent = 1 - (_remainingSeconds / _totalSeconds);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: percent),
      duration: const Duration(milliseconds: 500),
      builder: (context, animatedPercent, child) {
        return CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 10.0,
          percent: animatedPercent.clamp(0.0, 1.0),
          progressColor: Colors.red,
          backgroundColor: Colors.grey[300]!,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            _formatTime(_remainingSeconds),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
