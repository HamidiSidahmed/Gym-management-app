import 'package:hive/hive.dart';
part 'Blocked_Persons.g.dart';

@HiveType(typeId: 5)
class Blocked {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;
  @HiveField(2)
  DateTime blockeddate;
  @HiveField(3)
  DateTime experation;
  @HiveField(4)
  String? image;
   @HiveField(6)
  String plan;
  @HiveField(7)
  String paid;
  Blocked(this.name, this.phone, this.blockeddate, this.experation, this.image,this.plan,this.paid);
}
