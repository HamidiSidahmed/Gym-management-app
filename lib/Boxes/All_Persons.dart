import 'package:hive/hive.dart';

part 'All_Persons.g.dart';

@HiveType(typeId: 1)
class Persons {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  DateTime experation;
  @HiveField(3)
  String? image;
  @HiveField(4)
  bool state;
  @HiveField(5)
  DateTime startday;
  @HiveField(6)
  String plan;
  @HiveField(7)
  String paid;
  @HiveField(8)
  bool blocked;
  @HiveField(9)
  DateTime blockeddate;
  Persons(this.name, this.phone, this.experation, this.image, this.state,
      this.startday, this.plan, this.paid, this.blocked, this.blockeddate);
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'experation':experation.toString(),
      'image':image,
      'state':state,
      'startday':startday.toString(),
      'plan':plan,
      'paid':paid,
      'blocked': blocked,
      'blockeddate':blockeddate.toString()
    };
  }

    factory Persons.fromJson(Map<String, dynamic> json) {
    return Persons(
      json['name']??'',
      json['phone']??'',
      json['experation'] != null ? DateTime.parse(json['experation']) : DateTime.now(),
      json['image']??'',
      json['state']?? false,
      json['startday']!= null ? DateTime.parse(json['startday']) : DateTime.now(),
      json['plan']??'',
      json['paid']??'',
      json['blocked']??false,
      json['blockeddate']!= null ? DateTime.parse(json['blockeddate']) : DateTime.now(),
    
    );
  }
}
