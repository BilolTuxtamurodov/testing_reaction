import 'package:hive/hive.dart';


part 'user_data.g.dart';

@HiveType(typeId: 0, adapterName: 'UserDataAdapter')
class UserData {
  @HiveField(0)
  String? name;
  @HiveField(1)
  DateTime? lastResultTime;
  @HiveField(2)
  int? maximum;
  @HiveField(3)
  int? minimum;
  @HiveField(4)
  int? average;

}