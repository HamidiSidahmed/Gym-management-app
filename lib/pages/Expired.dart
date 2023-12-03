import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/hive_controller.dart';

class ExpiredPersons extends StatelessWidget {
  int index;
  ExpiredPersons({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final HiveController hiveController = Get.find();
    ImageProvider image() {
      if (hiveController.ReadExpiredPerson(index).image!.isEmpty) {
        return const AssetImage("assets/25.png");
      } else {
        return FileImage(File(hiveController.ReadExpiredPerson(index).image!));
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
                margin: EdgeInsets.only(left: 20.w, bottom: 5.w),
                width: 73.w,
                height: 73.w,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: image(),
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
                        "${hiveController.ReadExpiredPerson(index).name}",
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
                  margin: EdgeInsets.only(
                    left: 10.w,
                    top: 10.h,
                  ),
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
                        "${hiveController.ReadExpiredPerson(index).phone}",
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
                  width: 80.w,
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
                        "${hiveController.ReadExpiredPerson(index).plan}",
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
                      Text(
                        'inActive',
                        style: TextStyle(
                          color: Color(0xFF6C6C6C),
                          fontSize: 12.7.sp,
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
                        'Expired in:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${hiveController.ReadExpiredPerson(index).experation.day}/${hiveController.ReadExpiredPerson(index).experation.month}/${hiveController.ReadExpiredPerson(index).experation.year}',
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
                  margin: EdgeInsets.only(top: 10.h, left: 15.w),
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
                        '${hiveController.ReadExpiredPerson(index).paid} DZD',
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
                                          left: 97.w, top: 10.h),
                                      child: TextButton(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Color(0xFFC90000),
                                              fontSize: 13.sp,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          onPressed: () async {
                                            for (int i = 0;
                                                i <
                                                    hiveController
                                                        .filtereddata.length;
                                                i++) {
                                              if (hiveController
                                                              .ReadExpiredPerson(
                                                                  index)
                                                          .phone ==
                                                      hiveController
                                                          .readdata(i)
                                                          .phone &&
                                                  hiveController
                                                              .ReadExpiredPerson(
                                                                  index)
                                                          .name ==
                                                      hiveController
                                                          .readdata(i)
                                                          .name) {
                                                hiveController.deletedata(
                                                    i,
                                                    hiveController
                                                        .filtereddata);
                                                hiveController.deletedataBox(i);
                                              }
                                            }
                                            if (hiveController
                                                        .ReadExpiredPerson(
                                                            index)
                                                    .image !=
                                                null) {
                                              await deleteImage(hiveController
                                                      .ReadExpiredPerson(index)
                                                  .image!);
                                            }

                                            hiveController.DeleteExpiredPerson(
                                                index);
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
                                              fontSize: 13.sp,
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
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: const Icon(
                    Icons.block,
                    color: Color(0XFFCA0101),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
