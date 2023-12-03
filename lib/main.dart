import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedjdesign/Boxes/Blocked_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';
import 'package:tedjdesign/Security/security_class.dart';

import 'package:tedjdesign/pages/intro.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Boxes/Active_Persons.dart';
import 'Boxes/All_Persons.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
 
  await Permission.storage.request();
  await Permission.camera.request();

  Hive.registerAdapter(PersonsAdapter());
  Hive.registerAdapter(ActiveAdapter());
  Hive.registerAdapter(ExpiredAdapter());
  Hive.registerAdapter(securitydataAdapter());
  Hive.registerAdapter(BlockedAdapter());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  
  runApp(ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroPage(),
        );
      }));
}
