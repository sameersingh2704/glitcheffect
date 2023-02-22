import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class GlitchEffect extends StatefulWidget {
  const GlitchEffect({
    Key? key,
    required this.child,
    this.duration,
    this.colors,
    this.repeat = true,
  }) : super(key: key);

  /// The child Widget on which you want a glitch effect
  final Widget child;

  /// Whether the glitch effect should repeat over and over or only play once.
  ///
  /// The default value is true.
  final bool repeat;

  /// How long it should take until the glitch effect repeats itself. If
  /// [repeat] is false, this will only have effect once.
  ///
  /// The default value is 3 seconds.
  final Duration? duration;

  /// Colors you want to use for the glitch effect.
  ///
  /// A random color is used everytime the effects takes place
  ///
  /// If no colors are provided [default colors are Black, Grey and White].
  final List<Color>? colors;

  @override
  _GlitchEffectState createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late GlitchController _controller;

  static const Duration _defaultDuration = Duration(seconds: 3);

  /// Periodic timer of how often the glitch effect resets and starts over based
  /// on [widget.duration].
  ///
  /// If [widget.duration] is null, the [_defaultDuration] is used.
  late Timer _timer;

  @override
  void initState() {
    _controller = GlitchController(
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    _timer = widget.repeat
        ? Timer.periodic(widget.duration ?? _defaultDuration, (_) {
            _controller
              ..reset()
              ..forward();
          })
        : Timer.periodic(widget.duration ?? _defaultDuration, (_) {
            _controller
              ..reset()
              ..forward();
            _timer.cancel();
          });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _controller.dispose();
  }

  List<Color> get _colors {
    return widget.colors ??
        [
          Colors.white,
          Colors.grey,
          Colors.black,
        ];
  }

  Color get _randomColor => _colors[math.Random().nextInt(_colors.length)];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final color = _randomColor.withOpacity(0.5);
        if (!_controller.isAnimating) {
          return widget.child;
        }
        return Stack(
          children: [
            if (random.nextBool()) _clippedChild,
            Transform.translate(
              offset: randomOffset,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: <Color>[
                      color,
                      color,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: _clippedChild,
              ),
            ),
          ],
        );
      },
    );
  }

  Offset get randomOffset => Offset(
        (random.nextInt(10) - 5).toDouble(),
        (random.nextInt(10) - 5).toDouble(),
      );

  Widget get _clippedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}

final random = math.Random();

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;

  @override
  getClip(Size size) {
    final path = Path();
    double y = randomStep;
    while (y < size.height) {
      final yRandom = randomStep;
      double x = randomStep;

      while (x < size.width) {
        final xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y.toDouble()),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class GlitchController extends Animation<int>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  GlitchController({required this.duration});

  late Duration duration;

  List<Timer> _timers = [];
  bool isAnimating = false;

  void forward() {
    isAnimating = true;
    final oneStep = (duration.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _timers = [
      Timer(
        Duration(microseconds: oneStep),
        () => setValue(1),
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => setValue(2),
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => setValue(3),
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

  void setValue(int value) {
    _value = value;
    notifyListeners();
  }

  void reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  @override
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;
  late AnimationStatus _status;

  @override
  int get value => _value;
  late int _value;
}
