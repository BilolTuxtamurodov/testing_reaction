import 'package:hive_flutter/hive_flutter.dart';
import 'package:testing_reaction/data/user_data.dart';

class UserController {
  static late Box userBox ;
  static UserData? _user;

  static Future<void> init() async {
    userBox = Hive.box('person');
    var user = await userBox.get('user');
    if (user == null) {
      _user = UserData();
      userBox.put('user', _user);
      UserController.setUser(_user!);
    } else {
      UserController.setUser(user);
    }
  }

  static UserData getUser () {
    return _user??UserData();
  }

  static void setUser(UserData data) {
    _user = data;
    userBox.put('user', _user);
  }
}