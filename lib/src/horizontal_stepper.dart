import 'package:flutter/material.dart';
import 'types.dart';

class HorizontalStepperItem extends StatelessWidget {
  /// Stepper Item to show horizontal stepper
  const HorizontalStepperItem(
      {super.key,
      required this.isInverted,
      required this.badge,
      required this.element,
      required this.path,
      this.subPath,
      required this.badgePosition});

  final Widget badge;
  final Widget element;
  final Widget path;
  final Widget? subPath;
  final StepperBadgePosition badgePosition;
  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: badgePosition == StepperBadgePosition.start
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: isInverted ? getInvertedChildren() : getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    return [
      element,
      Row(
        children: [
          badgePosition != StepperBadgePosition.start
              ? Expanded(child: path)
              : const SizedBox(),
          badge,
          badgePosition != StepperBadgePosition.end
              ? Expanded(
                  child: badgePosition == StepperBadgePosition.start
                      ? path
                      : subPath ??
                          path, // we are taking sub path only is align of badge is center
                )
              : const SizedBox(),
        ],
      ),
    ];
  }

  List<Widget> getInvertedChildren() {
    return getChildren().reversed.toList();
  }
}
