import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tedjdesign/Boxes/Active_Persons.dart';
import 'package:tedjdesign/Boxes/All_Persons.dart';
import 'package:tedjdesign/Boxes/Blocked_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';
import 'package:tedjdesign/pages/Edit_Person.dart';

import '../controller/hive_controller.dart';

class AllPersons extends StatelessWidget {
  int index;
  AllPersons({required this.index, super.key});
  final HiveController hiveController = Get.find();

  bool isBlocked = false;
  void initBlock() {
    if (hiveController.readdata(index).blocked == false) {
      isBlocked = false;
    } else if (hiveController.readdata(index).blocked == true) {
      isBlocked = true;
    }
  }

  ImageProvider image() {
    if (hiveController.filtereddata[index].image!.isEmpty) {
      return AssetImage("assets/25.png");
    } else {
      return FileImage(File(hiveController.filtereddata[index].image!));
    }
  }
  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);

      if (await file.exists()) {
        await file.delete();
        print('Image deleted successfully');
      } else {
        print('Image does not exist');
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget state() {
      if (hiveController.readdata(index).blocked == false) {
        if (hiveController.isExpired(
                DateTime.now(), hiveController.readdata(index).experation) ==
            false) {
          return Text(
            "Active",
            style: TextStyle(
              color: Color(0xFF00A237),
              fontSize: (12.7.sp),
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w400,
            ),
          );
        } else {
          return Text(
            "inActive",
            style: TextStyle(
              color: Color(0xFF6C6C6C),
              fontSize: 12.7.sp,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w400,
            ),
          );
        }
      } else {
        return Text(
          "Blocked",
          style: TextStyle(
            color: Colors.red,
            fontSize: 12.7.sp,
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w400,
          ),
        );
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 25.h, left: 15.w, right: 15.w, top: 15.h),
      width: 300.w,
      height: 150.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        shadows: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, bottom: 5.h),
                width: 73.w,
                height: 73.w,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            child: Image(
                              image: image(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: image(),
                  ),
                ),
              )
            ],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 21.h, left: 10.w),
                  width: 115.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${hiveController.filtereddata[index].name}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.7.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  width: 115.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${hiveController.filtereddata[index].phone}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  width: 115.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${hiveController.filtereddata[index].plan}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 21.h, left: 15.w),
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      state()
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, top: 10.h),
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expired in:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${hiveController.filtereddata[index].experation.day}/${hiveController.filtereddata[index].experation.month}/${hiveController.filtereddata[index].experation.year}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, top: 10.h),
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paid:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${hiveController.filtereddata[index].paid} DZD",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 7.w, top: 25.h),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 125.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30.h, left: 5.w),
                                  child: Text(
                                    'Do you want to delete?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 90.w, top: 10.h),
                                      child: TextButton(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Color(0xFFC90000),
                                              fontSize: 13.5.sp,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          onPressed: ()async {
                                            for (int i = hiveController
                                                        .expired_box.length -
                                                    1;
                                                i >= 0;
                                                i--) {
                                              if (hiveController
                                                          .readdata(index)
                                                          .phone ==
                                                      hiveController
                                                              .ReadExpiredPerson(
                                                                  i)
                                                          .phone &&
                                                  hiveController
                                                          .readdata(index)
                                                          .name ==
                                                      hiveController
                                                              .ReadExpiredPerson(
                                                                  i)
                                                          .name) {
                                                hiveController
                                                    .DeleteExpiredPerson(i);
                                              }
                                            }
                                            for (int i = hiveController
                                                        .active_box.length -
                                                    1;
                                                i >= 0;
                                                i--) {
                                              if (hiveController
                                                          .readdata(index)
                                                          .phone ==
                                                      hiveController
                                                              .ReadActivePerson(
                                                                  i)
                                                          .phone &&
                                                  hiveController
                                                          .readdata(index)
                                                          .name ==
                                                      hiveController
                                                              .ReadActivePerson(
                                                                  i)
                                                          .name) {
                                                hiveController
                                                    .DeleteActivePerson(i);
                                              }
                                            }
                                            for (int i = hiveController
                                                        .blocked_box.length -
                                                    1;
                                                i >= 0;
                                                i--) {
                                              if (hiveController
                                                          .readdata(index)
                                                          .phone ==
                                                      hiveController
                                                          .readblockdata(i)
                                                          .phone &&
                                                  hiveController
                                                          .readdata(index)
                                                          .name ==
                                                      hiveController
                                                          .readblockdata(i)
                                                          .name) {
                                                hiveController
                                                    .deleteblockedindex(i);
                                              }
                                            }
                                            if ( hiveController
                                                    .readdata(index)
                                                    .image !=
                                                null) {
                                            await  deleteImage(hiveController
                                                  .readdata(index)
                                                  .image!);
                                            }
                                            hiveController.deletedata(index,
                                                hiveController.filtereddata);
                                            hiveController.deletedataBox(index);
                                            

                                            Navigator.pop(context);
                                          }),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 75.w, top: 10.h),
                                      child: TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.5.sp,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    child: const Icon(
                      Icons.delete,
                      color: Color(0XFFCA0101),
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
                        if (hiveController.readdata(index).blocked == false) {
                          return Container(
                            height: 125.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 25.h),
                                  width: 244.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GetBuilder<HiveController>(
                                        builder: (controller) {
                                          return Container(
                                              margin:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Text(
                                                "${hiveController.end_day.day}/${hiveController.end_day.month}/${hiveController.end_day.year}",
                                                style: TextStyle(
                                                    fontSize: 13.5.sp),
                                              ));
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 120.w),
                                        child: InkWell(
                                            onTap: () {
                                              showCupertinoModalPopup(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(35)),
                                                    height: 150.h,
                                                    child: CupertinoDatePicker(
                                                        initialDateTime:
                                                            DateTime(
                                                                2023, 1, 1),
                                                        minimumYear: 2023,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        onDateTimeChanged:
                                                            (DateTime time) {
                                                          hiveController
                                                              .readEndDate(
                                                                  time);
                                                        }),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 30.h,
                                              child: Image.asset(
                                                  "assets/calendar.png"),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      initBlock();
                                      isBlocked = !isBlocked;
                                      var object = hiveController
                                          .readdata(index) as Persons;
                                      object.blocked = isBlocked;
                                      object.blockeddate =
                                          hiveController.end_day;
                                      hiveController.myBox.putAt(index, object);

                                      hiveController.blocked_box.add(Blocked(
                                          hiveController.readdata(index).name,
                                          hiveController.readdata(index).phone,
                                          hiveController.end_day,
                                          hiveController
                                              .readdata(index)
                                              .experation,
                                          hiveController.readdata(index).image,
                                          hiveController.readdata(index).plan,
                                          hiveController.readdata(index).paid));

                                      for (int i = 0;
                                          i < hiveController.active_box.length;
                                          i++) {
                                        if (hiveController
                                                .readdata(index)
                                                .phone ==
                                            hiveController.ReadActivePerson(i)
                                                .phone) {
                                          hiveController.active_box.deleteAt(i);
                                        }
                                      }

                                      for (int i = 0;
                                          i < hiveController.expired_box.length;
                                          i++) {
                                        if (hiveController
                                                .readdata(index)
                                                .phone ==
                                            hiveController.ReadExpiredPerson(i)
                                                .phone) {
                                          hiveController.expired_box
                                              .deleteAt(i);
                                        }
                                      }

                                      hiveController.update();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Block',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            height: 125.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 25.h),
                                  width: 244.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GetBuilder<HiveController>(
                                        builder: (controller) {
                                          return Container(
                                              margin:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Text(
                                                "${hiveController.readdata(index).blockeddate.day}/${hiveController.readdata(index).blockeddate.month}/${hiveController.readdata(index).blockeddate.year}",
                                                style: TextStyle(
                                                    fontSize: 13.5.sp),
                                              ));
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 120.w),
                                        child: InkWell(
                                            child: Container(
                                          height: 30.h,
                                          child: Image.asset(
                                              "assets/calendar.png"),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      initBlock();
                                      isBlocked = !isBlocked;
                                      var object = hiveController
                                          .readdata(index) as Persons;
                                      object.blocked = isBlocked;
                                      hiveController.myBox.putAt(index, object);
                                      for (int i = hiveController
                                                  .blocked_box.length -
                                              1;
                                          i >= 0;
                                          i--) {
                                        if (hiveController
                                                .readdata(index)
                                                .phone ==
                                            hiveController
                                                .readblockdata(i)
                                                .phone) {
                                          hiveController.deleteblockedindex(i);
                                        }
                                      }
                                      if (hiveController.isExpired(
                                              DateTime.now(),
                                              hiveController
                                                  .readdata(index)
                                                  .experation) ==
                                          false) {
                                        hiveController.active_box.add(Active(
                                            hiveController.readdata(index).name,
                                            hiveController
                                                .readdata(index)
                                                .phone,
                                            DateTime.now(),
                                            hiveController
                                                .readdata(index)
                                                .experation,
                                            false,
                                            hiveController
                                                .readdata(index)
                                                .image,
                                            hiveController.readdata(index).plan,
                                            hiveController
                                                .readdata(index)
                                                .paid));
                                      } else {
                                        hiveController.expired_box.add(Expired(
                                            hiveController.readdata(index).name,
                                            hiveController
                                                .readdata(index)
                                                .phone,
                                            DateTime.now(),
                                            hiveController
                                                .readdata(index)
                                                .experation,
                                            true,
                                            hiveController
                                                .readdata(index)
                                                .image,
                                            hiveController.readdata(index).plan,
                                            hiveController
                                                .readdata(index)
                                                .paid));
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'unBlock',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Icon(
                      Icons.block,
                      color: Color(0XFFCA0101),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => EditPerson(index: index),
                      transition: Transition.upToDown,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Icon(Icons.edit),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
