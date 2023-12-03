import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tedjdesign/Boxes/Active_Persons.dart';
import 'package:tedjdesign/Boxes/All_Persons.dart';
import 'package:tedjdesign/Boxes/Blocked_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';
import 'package:tedjdesign/pages/login.dart';
import 'package:file_picker/file_picker.dart';

import '../Security/security_controller.dart';
import '../controller/hive_controller.dart';
import 'package:path_provider/path_provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveController hiveController = Get.put(HiveController());
    final Security SecurityController = Get.put(Security());

    Future<void> restoreBackup() async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restoring backup...')),
      );
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (file != null) {
        File files = File(file.files.single.path.toString());
        Map<String, dynamic> map = jsonDecode(await files.readAsString());

        for (var key in map.keys) {
          Persons person = Persons.fromJson(map[key]);
          hiveController.myBox.add(Persons(
              person.name,
              person.phone,
              person.experation,
              person.image,
              person.state,
              person.startday,
              person.plan,
              person.paid,
              person.blocked,
              person.blockeddate));
          if (person.blocked == false) {
            if (hiveController.isExpired(DateTime.now(), person.experation) ==
                false) {
              hiveController.active_box.add(Active(
                  person.name,
                  person.phone,
                  person.startday,
                  person.experation,
                  false,
                  person.image,
                  person.plan,
                  person.paid));
            } else {
              hiveController.expired_box.add(Expired(
                  person.name,
                  person.phone,
                  person.startday,
                  person.experation,
                  true,
                  person.image,
                  person.plan,
                  person.paid));
            }
          } else {
            hiveController.blocked_box.add(Blocked(
                person.name,
                person.phone,
                person.blockeddate,
                person.experation,
                person.image,
                person.plan,
                person.paid));
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Restored Successfully')),
        );
      }
    }

    Future<Directory> _getDirectory() async {
      //This is the name of the folder where the backup is stored
      Directory? newDirectory = await getExternalStorageDirectory();
      if (await newDirectory!.exists() == false) {
        return newDirectory.create(recursive: true);
      }
      return newDirectory;
    }

    Future<void> createBackup() async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating backup...')),
      );
      Map<String, dynamic> map = hiveController.myBox
          .toMap()
          .map((key, value) => MapEntry(key.toString(), value));
      String json = jsonEncode(map);
      Directory dir = await _getDirectory();

      String path =
          '${dir.path}${DateTime.now()}.hive'; //Change .json to your desired file format(like .barbackup or .hive).
      File backupFile = File(path);
      if (await backupFile.exists()) {
        await backupFile.delete();
      }

      await backupFile.writeAsString(json);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Successfully')),
      );
    }

    return Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Stack(
          children: [
            Positioned(
              child: Center(
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Ellipse 2.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Colors.black.withOpacity(0), Colors.black],
                ),
              ),
            ),
            Positioned(
              left: 78.w,
              top: 309.h,
              child: Text(
                'WELCOME TO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.sp,
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 72.w,
              top: 345.h,
              child: Container(
                width: 235.w,
                height: 154.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90.w,
              top: 630.h,
              child: InkWell(
                onTap: () async {
                  Get.to(() => LoginPage(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 150));
                  hiveController.filtereddata =
                      hiveController.myBox.values.toList();
                },
                child: Container(
                  width: 204.w,
                  height: 50.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC7C7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90.w,
              top: 690.h,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 100.h,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 95.w),
                              child: InkWell(
                                onTap: () {
                                  restoreBackup();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Restore',
                                  style: TextStyle(
                                    color: Color(0xFF242222),
                                    fontSize: 18.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 75.w),
                              child: InkWell(
                                onTap: () {
                                  createBackup();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Backup',
                                  style: TextStyle(
                                    color: Color(0xFF242222),
                                    fontSize: 18.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 204.w,
                  height: 50.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC7C7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'DATA',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
