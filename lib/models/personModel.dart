import 'package:hive_flutter/hive_flutter.dart';
part 'personModel.g.dart';

@HiveType(typeId: 1)
class PersonModel {
  @HiveField(0)
  String email;
  @HiveField(1)
  String passWord;
  PersonModel({
    required this.email,
    required this.passWord,
  });
}
