import 'package:flutter/material.dart';
import 'package:universal_stepper/universal_stepper.dart';

import 'custom/dotted_line_painer.dart';
import 'models/stepper_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentStep = 2;

  StepperBadgePosition badgePosition =
      StepperBadgePosition.center; // Set the desired badgePosition

  bool isInverted = false;

  List<StepperData> stepperData = [
    const StepperData(
      title: "Order Placed",
      subtitle: "Your order has been placed",
    ),
    const StepperData(
      title: "Preparing",
      subtitle: "Your order is being prepared",
    ),
    const StepperData(
      title: "On the way",
      subtitle: "",
    ),
    const StepperData(
      title: "Delivered",
      subtitle: "Your order was delivered successfully",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SegmentedButton<StepperBadgePosition>(
                        segments: const [
                          ButtonSegment(
                            value: StepperBadgePosition.start,
                            label: Text('StepperBadgePosition.start'),
                          ),
                          ButtonSegment(
                            value: StepperBadgePosition.center,
                            label: Text('StepperBadgePosition.center'),
                          ),
                          ButtonSegment(
                            value: StepperBadgePosition.end,
                            label: Text('StepperBadgePosition.end'),
                          ),
                        ],
                        selected: {badgePosition},
                        onSelectionChanged: (value) {
                          setState(() {
                            badgePosition = value.first;
                          });
                        },
                      ),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(
                            value: true,
                            label: Text('Inverted'),
                          ),
                          ButtonSegment(
                            value: false,
                            label: Text('Not Inverted'),
                          ),
                        ],
                        selected: {isInverted},
                        onSelectionChanged: (value) {
                          setState(() {
                            isInverted = value.first;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: UniversalStepper(
                      inverted: isInverted,
                      stepperDirection: Axis.vertical,
                      elementBuilder: (context, index) {
                        return Expanded(
                          child: Container(
                            padding: badgePosition ==
                                    StepperBadgePosition.center
                                ? const EdgeInsets.all(10)
                                : badgePosition == StepperBadgePosition.start
                                    ? const EdgeInsets.only(
                                        left: 10, bottom: 15)
                                    : const EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: badgePosition ==
                                      StepperBadgePosition.center
                                  ? MainAxisAlignment.center
                                  : badgePosition == StepperBadgePosition.start
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                Text(
                                  stepperData[index].title!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                if (stepperData[index].subtitle!.isNotEmpty)
                                  Text(
                                    stepperData[index].subtitle!,
                                    textAlign: TextAlign.start,
                                  ),
                                if (index == 2)
                                  SizedBox(
                                    width: 200,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Container(
                                        color: Colors.green,
                                        child: const Center(
                                            child: Text("Look on Map")),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                      badgeBuilder: (context, index) {
                        return Container(
                          width: 30,
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const FittedBox(
                              child: Icon(Icons.fastfood, color: Colors.white)),
                        );
                      },
                      pathBuilder: (context, index) {
                        return badgePosition == StepperBadgePosition.center
                            ? Container(
                                color: index == 0
                                    ? Colors.transparent
                                    : (index <= currentStep
                                        ? Colors.green
                                        : Colors.grey),
                                width: 4,
                              )
                            : badgePosition == StepperBadgePosition.start
                                ? Container(
                                    color: index == stepperData.length - 1
                                        ? Colors.transparent
                                        : (index < currentStep
                                            ? Colors.green
                                            : Colors.grey),
                                    width: 4,
                                  )
                                : Container(
                                    color: (index < currentStep
                                        ? Colors.green
                                        : Colors.grey),
                                    width: 4,
                                  );
                      },
                      subPathBuilder: (context, index) {
                        return Container(
                          color: index == stepperData.length - 1
                              ? Colors.transparent
                              : (index < currentStep
                                  ? Colors.green
                                  : Colors.grey),
                          width: 4,
                        );
                      },
                      elementCount: stepperData.length,
                      badgePosition: badgePosition,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: UniversalStepper(
                      inverted: isInverted,
                      stepperDirection: Axis.horizontal,
                      elementBuilder: (context, index) {
                        return Container(
                          width: 300,
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                stepperData[index].title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              if (stepperData[index].subtitle!.isNotEmpty)
                                Text(
                                  stepperData[index].subtitle!,
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        );
                      },
                      badgeBuilder: (context, index) {
                        return Container(
                          width: 30,
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const FittedBox(
                              child: Icon(Icons.fastfood, color: Colors.white)),
                        );
                      },
                      pathBuilder: (context, index) {
                        return badgePosition == StepperBadgePosition.center
                            ? CustomPaint(
                                painter: DottedLinePainter(
                                  color: index == 0
                                      ? Colors.transparent
                                      : (index <= currentStep
                                          ? Colors.green
                                          : Colors.white),
                                ),
                              )
                            : badgePosition == StepperBadgePosition.start
                                ? CustomPaint(
                                    painter: DottedLinePainter(
                                      color: index == stepperData.length - 1
                                          ? Colors.transparent
                                          : (index < currentStep
                                              ? Colors.green
                                              : Colors.white),
                                    ),
                                  )
                                : CustomPaint(
                                    painter: DottedLinePainter(
                                      color: index < currentStep
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                  );
                      },
                      subPathBuilder: (context, index) {
                        return CustomPaint(
                          painter: DottedLinePainter(
                            color: index == stepperData.length - 1
                                ? Colors.transparent
                                : (index < currentStep
                                    ? Colors.green
                                    : Colors.white),
                          ),
                        );
                      },
                      elementCount: stepperData.length,
                      badgePosition: badgePosition,
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}