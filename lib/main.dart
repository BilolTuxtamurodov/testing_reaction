import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:testing_reaction/app.dart';
import 'package:testing_reaction/controller/user_controller.dart';
import 'package:testing_reaction/data/user_data.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox('person');
  await UserController.init();
  runApp(const MyApp());
}
