import 'dart:math';

import 'package:flutter/material.dart';

import 'glitch_clipper.dart';
import 'glitch_controller.dart';

class GlitchEffect extends StatefulWidget {
  const GlitchEffect({
    Key? key,
    required this.child,
    this.controller,
  }) : super(key: key);

  /// The child Widget on which you want a glitch effect.
  final Widget child;

  /// Controls the glitch effect.
  final GlitchController? controller;

  @override
  State createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late GlitchController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? GlitchController();
    if (_controller.isStartingOnInitState) _controller.start();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Color get _randomColor =>
      _controller.colors[_random.nextInt(_controller.colors.length)];

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
            if (_random.nextBool()) _clippedChild,
            Transform.translate(
              offset: randomOffset,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: <Color>[color, color],
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
        (_random.nextInt(10) - 5).toDouble(),
        (_random.nextInt(10) - 5).toDouble(),
      );

  Widget get _clippedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}
