import 'package:hive/hive.dart';
part 'Active_Persons.g.dart';

@HiveType(typeId: 2)
class Active {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;
  @HiveField(2)
  DateTime selecteddate;
  @HiveField(3)
  DateTime experation;
  @HiveField(4)
  bool state;
  @HiveField(5)
  String? image;
   @HiveField(6)
  String plan;
  @HiveField(7)
  String paid;
  Active(this.name, this.phone, this.selecteddate, this.experation,this.state, this.image,this.plan,this.paid);


}
