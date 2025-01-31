import 'package:flutter/material.dart';

import 'types.dart';

class VerticalStepperItem extends StatelessWidget {
  /// Stepper Item to show vertical stepper
  const VerticalStepperItem({
    super.key,
    required this.badge,
    required this.element,
    required this.path,
    this.subPath,
    required this.badgePosition,
    required this.isInverted,
  });

  final Widget badge;
  final Widget element;
  final Widget path;
  final Widget? subPath;
  final StepperBadgePosition badgePosition;
  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment:
            isInverted ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isInverted ? getChildren().reversed.toList() : getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
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
      element,
    ];
  }
}
