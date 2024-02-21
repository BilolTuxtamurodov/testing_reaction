import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testing_reaction/controller/user_controller.dart';
import 'package:testing_reaction/data/result_data.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  int count = 0;
  List<ResultData> results = [];
  bool isStart = false;
  bool isDone = false;
  late DateTime startTime;
  late DateTime finishedTime;
  late int maximum;
  late int average;
  late Duration averageSeconds;
  late Duration maximumSeconds;
  late int minimum;
  late Duration minimumSeconds;

  int getSeconds() {
    int i = Random().nextInt(4);
    return i >= 2 ? i : 2;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Are you ready ?'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(30)),
                  child: !isDone
                      ? Visibility(
                          visible: isStart,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                finishedTime = DateTime.now();
                                results.add(ResultData(
                                    startedTime: startTime,
                                    finishedTime: finishedTime));
                                isStart = false;
                              });
                              if (count == 5) {
                                getResults();
                                setState(() {
                                  isDone = true;
                                });
                              } else {
                                count++;
                                Timer(Duration(seconds: getSeconds()), () {
                                  setState(() {
                                    isStart = true;
                                    startTime = DateTime.now();
                                  });
                                });
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                const Text('Finished'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Maximum is : $maximumSeconds'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Minimum is : $minimumSeconds'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Average is : $averageSeconds'),
                              ],
                            ),
                          ),
                        ),
                )),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            TextButton(
                onPressed: !isDone
                    ? () => setState(() {
                          Timer(const Duration(seconds: 2), () {
                            setState(() {
                              count++;
                              isStart = true;
                              startTime = DateTime.now();
                            });
                          });
                        })
                    : () => reset(),
                child: !isDone
                    ? const Text(
                        'Start',
                        style: TextStyle(fontSize: 20),
                      )
                    : const Text(
                        'Retry',
                        style: TextStyle(fontSize: 20),
                      ))
          ],
        ));
  }

  void getResults() {
    int av = 0;
    List<int> seconds = [];
    for (ResultData data in results) {
      var difference = data.finishedTime?.difference(data.startedTime!);
      seconds.add(difference!.inMilliseconds);
      av += difference.inMilliseconds;
    }
    seconds.sort();

    maximum = seconds[0];
    minimum = seconds[seconds.length - 1];
    average = av ~/ 5;

    averageSeconds = Duration(milliseconds: average);
    maximumSeconds = Duration(milliseconds: maximum);
    minimumSeconds = Duration(milliseconds: minimum);

    var user = UserController.getUser();

    if ((user.average == null) ||
        (averageSeconds.inMilliseconds > user.average!)) {
      user.average = averageSeconds.inMilliseconds;
    }

    if ((user.maximum == null) ||
        (user.maximum! > maximumSeconds.inMilliseconds)) {
      user.maximum = maximumSeconds.inMilliseconds;
    }

    if ((user.minimum == null) ||
        (user.minimum! < minimumSeconds.inMilliseconds)) {
      user.minimum = minimumSeconds.inMilliseconds;
    }

    UserController.setUser(user);
  }

  void reset() {
    setState(() {
      count = 0;
      isDone = false;
      isStart = false;
      results = [];
      minimum = 0;
      maximum = 0;
      minimumSeconds = const Duration();
      maximumSeconds = const Duration();
    });
  }
}
