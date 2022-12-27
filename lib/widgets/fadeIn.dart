import 'dart:async';

import 'package:flutter/widgets.dart';

class FadeIn extends StatefulWidget {
  /// Fade-in controller
  final FadeInController? controller;

  /// Child widget to fade-in
  final Widget? child;

  /// Duration of fade-in. Defaults to 250ms
  final Duration duration;

  /// Fade-in curve. Defaults to [Curves.easeIn]
  final Curve curve;

  const FadeIn({
    Key? key,
    this.controller,
    this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeIn,
  }) : super(key: key);

  @override
  _FadeInState createState() => _FadeInState();
}

enum FadeInAction {
  fadeIn,
  fadeOut,
}

/// Fade-in controller which dispatches fade-in/fade-out actions
class FadeInController {
  final _streamController = StreamController<FadeInAction>();

  /// Automatically starts the initial fade-in. Defaults to false
  final bool autoStart;

  FadeInController({this.autoStart = false});

  void dispose() => _streamController.close();

  /// Fades-in child
  void fadeIn() => run(FadeInAction.fadeIn);

  /// Fades-out child
  void fadeOut() => run(FadeInAction.fadeOut);

  /// Dispatches a [FadeInAction]
  void run(FadeInAction action) => _streamController.add(action);

  /// Stream of [FadeInAction]s dispatched by this controller
  Stream<FadeInAction> get stream => _streamController.stream;
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  late AnimationController _controller;
  StreamSubscription<FadeInAction>? _listener;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _setupCurve();

    if (widget.controller?.autoStart != false) {
      fadeIn();
    }

    _listen();
  }

  void _setupCurve() {
    final curve = CurvedAnimation(parent: _controller, curve: widget.curve);

    Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(curve);
  }

  void _listen() {
    if (_listener != null) {
      _listener!.cancel();
      _listener = null;
    }

    if (widget.controller != null) {
      _listener = widget.controller!.stream.listen(_onAction);
    }
  }

  void _onAction(FadeInAction action) {
    switch (action) {
      case FadeInAction.fadeIn:
        fadeIn();
        break;
      case FadeInAction.fadeOut:
        fadeOut();
        break;
    }
  }

  @override
  void didUpdateWidget(FadeIn oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _listen();
    }

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.curve != widget.curve) {
      _setupCurve();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }

  /// Fades-in child
  void fadeIn() => _controller.forward();

  /// Fades-out child
  void fadeOut() => _controller.reverse();
}
