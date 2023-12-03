import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tedjdesign/Security/security_class.dart';

class Security extends GetxController {
  late Box SecurityData;
  late securitydata Data;
  late Box index;
  @override
  void onInit() async {
    super.onInit();
    SecurityData = await Hive.openBox<securitydata>("security");
    index = await Hive.openBox<int>("i");
  }

  void push_secured_data(String username, String password) {
    SecurityData.put(username, securitydata(username, password));
    update();
  }

  void push_index(int i) {
    index.put("i", i);
  }

  void read_index() {
    index.get("i");
  }
}
