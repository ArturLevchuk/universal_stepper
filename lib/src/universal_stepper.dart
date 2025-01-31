import 'package:flutter/material.dart';

import 'horizontal_stepper.dart';
import 'types.dart';
import 'vertical_stepper.dart';

class UniversalStepper extends StatelessWidget {
  /// UniversalStepper is a package, which helps build
  /// customizable and easy to manage steppers.
  ///
  /// The package can be used to build horizontal as well
  /// as vertical steppers just by providing [Axis] parameter.
  const UniversalStepper({
    super.key,
    required this.stepperDirection,
    this.inverted = false,
    required this.elementBuilder,
    required this.badgeBuilder,
    required this.pathBuilder,
    this.subPathBuilder,
    this.badgePosition = StepperBadgePosition.center,
    required this.elementCount,
  });

  /// Stepper direction takes [Axis]
  ///
  /// Use [Axis.horizontal] to get horizontal stepper or [Axis.vertical] to get vertical stepper
  final Axis stepperDirection;

  /// Direction of the stepper items. By default it is [false] and direction is from left to right for vertical steppers and from top to bottom for horizontal steppers. By setting it to [true] it will be from right to left for vertical steppers and from bottom to top for horizontal steppers
  final bool inverted;

  /// Builds the main element widget for each step.
  final Widget Function(BuildContext context, int index) elementBuilder;

  /// Builds the badge widget for each step.
  final Widget Function(BuildContext context, int index) badgeBuilder;

  /// Builds the path widget between steps. Takes maximum of available space based on each element size. To make path wider or longer consider using fixed width or height.
  final Widget Function(BuildContext context, int index) pathBuilder;

  /// Optionally builds a sub-path widget for each step. Used only if [badgePosition] is [StepperBadgePosition.center] for path line under the badge. If not provided, [pathBuilder] will be used.
  final Widget Function(BuildContext context, int index)? subPathBuilder;

  /// Position of the badge. By default it is [StepperBadgePosition.center] and badge will be placed in the center of the path. If [StepperBadgePosition.start] it will be placed at the start of the path. If [StepperBadgePosition.end] it will be placed at the end of the path.
  final StepperBadgePosition badgePosition;

  /// Number of steps
  final int elementCount;

  @override
  Widget build(BuildContext context) {
    var caa = stepperDirection == Axis.horizontal
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    if (inverted) {
      // invert Alignment
      caa = caa == CrossAxisAlignment.end
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end;
    }
    return SizedBox(
      child: Flex(
        crossAxisAlignment: caa,
        direction: stepperDirection,
        children: List.generate(
            elementCount, (index) => _getPreferredStepper(context, index)),
      ),
    );
  }

  Widget _getPreferredStepper(BuildContext context, index) {
    if (stepperDirection == Axis.horizontal) {
      return HorizontalStepperItem(
        isInverted: inverted,
        badge: badgeBuilder(context, index),
        element: elementBuilder(context, index),
        path: pathBuilder(context, index),
        subPath: subPathBuilder?.call(context, index),
        badgePosition: badgePosition,
      );
    } else {
      return VerticalStepperItem(
        badge: badgeBuilder(context, index),
        element: elementBuilder(context, index),
        path: pathBuilder(context, index),
        subPath: subPathBuilder?.call(context, index),
        badgePosition: badgePosition,
        isInverted: inverted,
      );
    }
  }
}
