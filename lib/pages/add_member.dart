import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tedjdesign/Boxes/Active_Persons.dart';
import 'package:tedjdesign/Boxes/All_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';
import '../controller/hive_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class AddPerson extends StatelessWidget {
  const AddPerson({super.key});

  @override
  Widget build(BuildContext context) {
    var compressedfile;
    final HiveController hiveController = Get.find();
    hiveController.imagepicker = null;

    Future<Directory> _getDirectory() async {
      //This is the name of the folder where the backup is stored
      Directory? newDirectory = await getExternalStorageDirectory();
      if (await newDirectory!.exists() == false) {
        return newDirectory.create(recursive: true);
      }
      return newDirectory;
    }

    Future compress() async {
      Directory dir = await _getDirectory();
      if (hiveController.imagepicker == null) {
        return null;
      } else {
        var original = File(hiveController.imagepicker!.path);
        compressedfile = await FlutterImageCompress.compressAndGetFile(
            original.path, '${dir.path}${DateTime.now()}.jpg',
            minHeight: 350, minWidth: 350, quality: 80);
        if (compressedfile != null) {
          print("gg");
        }
      }
      hiveController.update();
    }

    ImageProvider comImage() {
      if (compressedfile == null) {
        return AssetImage("assets/25.png");
      } else {
        return FileImage(File(compressedfile.path));
      }
    }

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController exp_day = TextEditingController();
    TextEditingController plan = TextEditingController();
    TextEditingController paid = TextEditingController();

    String picked = "";
    hiveController.end_day = DateTime.now().add(Duration(days: 30));
    return Builder(builder: (context) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  child: Image.asset(
                    "assets/add.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.00, -1.00),
                      end: const Alignment(0, 1),
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 15.h, top: 175.h, left: 5.w),
                        child: Text(
                          'ADD A MEMBER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            context: context,
                            builder: (context) {
                              return Container(
                                width: 100.w,
                                height: 125.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10.h, left: 45.w),
                                      width: 1.sw,
                                      height: 50.h,
                                      child: InkWell(
                                        onTap: () async {
                                          await hiveController
                                              .takephoto(ImageSource.camera);
                                          await compress();
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 0),
                                              child: Image.asset(
                                                  "assets/camera.png"),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Text(
                                                'Take a Picture',
                                                style: TextStyle(
                                                  color: Color(0xFF232121),
                                                  fontSize: 13.sp,
                                                  fontFamily: 'Helvetica',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      child: InkWell(
                                        onTap: () async {
                                          await hiveController
                                              .takephoto(ImageSource.gallery);
                                          await compress();
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              margin: EdgeInsets.only(
                                                left: 45.w,
                                              ),
                                              child: Image.asset(
                                                  "assets/gallery.png"),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 20.w,
                                              ),
                                              child: Text(
                                                'Export From Gallery',
                                                style: TextStyle(
                                                  color: Color(0xFF232121),
                                                  fontSize: 13.sp,
                                                  fontFamily: 'Helvetica',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: GetBuilder<HiveController>(
                          builder: (controller) {
                            return Container(
                              margin: EdgeInsets.only(top: 20.h),
                              width: 94.w,
                              height: 94.h,
                              child: CircleAvatar(
                                backgroundImage: comImage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: 246.w,
                        height: 44.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14.w, top: 3.h),
                              width: 108.w,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.7799999713897705),
                                  fontSize: 10.5.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 16.5.w,
                              ),
                              child: TextField(
                                  controller: name,
                                  style: TextStyle(fontSize: 13.5.sp),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: InputBorder.none)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: 246.w,
                        height: 44.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14.w, top: 3.h),
                              width: 108.w,
                              child: Text(
                                'Phone',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.7799999713897705),
                                  fontSize: 10.5.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 16.5.w,
                              ),
                              child: TextField(
                                  keyboardType: TextInputType.phone,
                                  controller: phone,
                                  style: TextStyle(fontSize: 13.5.sp),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: InputBorder.none)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: 246.w,
                        height: 44.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14.w, top: 3.h),
                              width: 108.w,
                              child: Text(
                                'Experation Date',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.7799999713897705),
                                  fontSize: 10.5.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            GetBuilder<HiveController>(
                              builder: (controller) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: 16.5.w,
                                    top: 17.h,
                                  ),
                                  child: Text(
                                      "${hiveController.end_day.day}/${hiveController.end_day.month}/${hiveController.end_day.year}",
                                      style: TextStyle(fontSize: 13.5.sp)),
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.w),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  onTap: () {
                                    compress();
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          height: 175.h,
                                          child: CupertinoDatePicker(
                                              initialDateTime:
                                                  DateTime(2023, 1, 1),
                                              minimumYear: 2023,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              onDateTimeChanged:
                                                  (DateTime time) {
                                                hiveController
                                                    .readEndDate(time);
                                              }),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      width: 20.w,
                                      child:
                                          Image.asset("assets/calendar.png"))),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: 246.w,
                        height: 44.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14.w, top: 3.h),
                              width: 108.w,
                              child: Text(
                                'Plan',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.7799999713897705),
                                  fontSize: 10.5.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 16.5.w,
                              ),
                              child: TextField(
                                  controller: plan,
                                  style: TextStyle(fontSize: 13.5.sp),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: InputBorder.none)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        width: 246.w,
                        height: 44.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14.w, top: 3.h),
                              width: 108.w,
                              child: Text(
                                'Amount paid',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.7799999713897705),
                                  fontSize: 10.5.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 16.5.w,
                              ),
                              child: TextField(
                                  controller: paid,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 13.5.sp),
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (compressedfile == null) {
                            picked = "";
                          } else {
                            picked = compressedfile.path;
                          }
                          Get.back();
                          print(picked);
                          hiveController.myBox.add(Persons(
                              name.text,
                              phone.text,
                              hiveController.end_day,
                              picked,
                              hiveController.isExpired(
                                  DateTime.now(), hiveController.end_day),
                              DateTime.now(),
                              plan.text,
                              paid.text,
                              false,
                              DateTime.now()));

                          if (hiveController.isExpired(
                                  DateTime.now(), hiveController.end_day) ==
                              false) {
                            hiveController.active_box.add(Active(
                                name.text,
                                phone.text,
                                DateTime.now(),
                                hiveController.end_day,
                                false,
                                picked,
                                plan.text,
                                paid.text));
                          }
                          if (hiveController.isExpired(
                                  DateTime.now(), hiveController.end_day) ==
                              true) {
                            hiveController.expired_box.add(Expired(
                                name.text,
                                phone.text,
                                DateTime.now(),
                                hiveController.end_day,
                                true,
                                picked,
                                plan.text,
                                paid.text));
                          }
                          hiveController.filterPersons("");
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40.h),
                          width: 106.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFC7C7C7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
