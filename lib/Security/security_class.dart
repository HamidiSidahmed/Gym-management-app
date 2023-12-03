import 'package:hive/hive.dart';
part 'security_class.g.dart';

@HiveType(typeId: 4)
class securitydata {
  @HiveField(0)
  String user_name;
  @HiveField(1)
  String password;
  securitydata(this.user_name, this.password);
}
