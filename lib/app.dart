import 'package:flutter/material.dart';
import 'package:testing_reaction/controller/user_controller.dart';
import 'package:testing_reaction/data/user_data.dart';
import 'package:testing_reaction/pages/home_page.dart';
import 'package:testing_reaction/pages/result_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  late UserData user;

  @override
  void initState() {
    user = UserController.getUser();
    super.initState();
  }

  var pages = [
    const HomePage(),
    const ResultPage(),
  ];

  var pagesIcon = [
    const NavigationDestination(
        icon: Icon(Icons.home),
        label:'Home',
    ),
    const NavigationDestination(
        icon: Icon(Icons.analytics_outlined),
        label:'Result',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing reaction',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Testing your reaction speed')),
          backgroundColor: Colors.blueGrey,
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: NavigationBar(
          destinations: pagesIcon,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
