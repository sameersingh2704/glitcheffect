import 'dart:async';

import 'package:flutter/material.dart';

class GlitchController extends Animation<int>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  GlitchController({
    this.isRepeating = true,
    this.isStartingOnInitState = true,
    this.duration = const Duration(milliseconds: 400),
    this.pauseDuration = const Duration(seconds: 3),
    this.colors = const [Colors.white, Colors.grey, Colors.black],
  }) : assert(colors.isNotEmpty);

  /// Whether the glitch effect should repeat over and over or only play once.
  ///
  /// The default value is true.
  bool isRepeating;

  /// Whether the glitch effect should start when widget gets rendered.
  ///
  /// The default value is true.
  /// If false start effect with [start].
  bool isStartingOnInitState;

  /// How long the glitch effect should be.
  /// The default value is 400 milliseconds.
  Duration duration;

  /// How long it should take until the glitch effect repeats itself. If
  /// [isRepeating] is false, this will only have effect once.
  ///
  /// The default value is 3 seconds.
  Duration pauseDuration;

  /// List of colors that you want to use for glitch effect.
  ///
  /// A random color is used everytime the effects takes place
  ///
  /// If no colors are provided [default colors are Black, Grey and White].
  List<Color> colors;

  late AnimationStatus _status;
  late int _value;

  Timer? _runTimer;
  List<Timer> _effectTimers = [];
  bool isAnimating = false;

  /// Creates the glitch effect once.
  void forward() {
    isAnimating = true;
    final oneStep = (duration.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _effectTimers = [
      Timer(
        Duration(microseconds: oneStep),
        () => _setValue(1),
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => _setValue(2),
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => _setValue(5),
      ),
      Timer(
        Duration(microseconds: oneStep * 4),
        () {
          _status = AnimationStatus.completed;
          isAnimating = false;
          notifyListeners();
        },
      ),
    ];
  }

  /// Resets the glitch effect.
  void reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  /// Starts the glitch effect in a loop based on [isRepeating].
  void start() {
    stop();
    if (isRepeating) {
      _runTimer = Timer.periodic(pauseDuration, (_) {
        reset();
        forward();
      });
    } else {
      _runTimer = Timer(pauseDuration, () {
        reset();
        forward();
        stop();
      });
    }
  }

  /// Stops the loop of [start].
  void stop() {
    _runTimer?.cancel();
    _runTimer = null;
  }

  void _setValue(value) {
    _value = value;
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    for (final timer in _effectTimers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;

  @override
  int get value => _value;
}
