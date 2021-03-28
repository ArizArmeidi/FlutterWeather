import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final Widget child;
  final double delay;

  FadeIn({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(
          AniProps.translateX, Tween(begin: 130.0, end: 0.0), 500.milliseconds);

    return PlayAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
