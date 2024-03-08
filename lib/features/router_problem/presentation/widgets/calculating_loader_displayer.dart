import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:router/core/helper/extensions.dart';

class CalculatingLoaderDisplayer extends StatefulWidget {
  final double? progress;
  const CalculatingLoaderDisplayer({
    super.key,
    this.progress,
  });

  @override
  State<CalculatingLoaderDisplayer> createState() =>
      _CalculatingLoaderDisplayerState();
}

class _CalculatingLoaderDisplayerState extends State<CalculatingLoaderDisplayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController progressAnimationController;
  @override
  void initState() {
    super.initState();
    progressAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void didUpdateWidget(covariant CalculatingLoaderDisplayer oldWidget) {
    if (widget.progress == 0 || widget.progress == null) {
      progressAnimationController.value = 0;
    } else {
      progressAnimationController.animateTo(widget.progress!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          getProgressText(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        SizedBox.square(
          dimension: 100,
          child: AnimatedBuilder(
            animation: progressAnimationController,
            builder: (context, child) => CircularProgressIndicator(
              value: widget.progress == null
                  ? null
                  : progressAnimationController.value,
            ),
          ),
        ),
      ],
    );
  }

  String getProgressText() {
    if (widget.progress == null) {
      return "";
    }
    return widget.progress!.toPercentText();
  }
}
