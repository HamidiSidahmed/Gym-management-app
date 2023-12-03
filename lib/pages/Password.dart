import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tedjdesign/Security/security_controller.dart';
import 'package:tedjdesign/controller/hive_controller.dart';

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    final Security SecurityController = Get.find();
    final HiveController hiveController = Get.find();

    bool visible = false;
    TextEditingController prev_password = TextEditingController();
    TextEditingController new_password = TextEditingController();
    TextEditingController confirmed_password = TextEditingController();
    Widget widget = Container();
    void logincheck(Widget text) {
      widget = text;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          decoration: ShapeDecoration(
            color: Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x7C000000),
                blurRadius: 33,
                offset: Offset(1, -1),
                spreadRadius: 0,
              )
            ],
          ),
          width: 1.sw,
          height: 1.sh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 75.h),
                  alignment: Alignment.center,
                  width: 180.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 80.h),
                  width: 139.w,
                  child: Text(
                    'PASSWORD',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: 246.w,
                  height: 50.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC7C7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w, top: 4.h),
                        width: 108.w,
                        child: Text(
                          'Current Password',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7799999713897705),
                            fontSize: 11.5.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: GetBuilder<HiveController>(
                          builder: (controller) {
                            return TextField(
                              obscureText: !visible,
                              controller: prev_password,
                              cursorWidth: 1,
                              style: TextStyle(fontSize: 13.5.sp),
                              textAlignVertical: TextAlignVertical.bottom,
                              cursorColor: Colors.black,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: 246.w,
                  height: 50.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC7C7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w, top: 4.h),
                        width: 108.w,
                        child: Text(
                          'New Password',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7799999713897705),
                            fontSize: 11.5.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: GetBuilder<HiveController>(
                          builder: (controller) {
                            return TextField(
                              obscureText: !visible,
                              controller: new_password,
                              cursorWidth: 1,
                              style: TextStyle(fontSize: 13.5.sp),
                              textAlignVertical: TextAlignVertical.bottom,
                              cursorColor: Colors.black,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: (246.w),
                  height: (50.h),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC7C7C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w, top: 4.h),
                        width: 108.w,
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7799999713897705),
                            fontSize: 11.5.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: GetBuilder<HiveController>(
                          builder: (controller) {
                            return TextField(
                              obscureText: !visible,
                              controller: confirmed_password,
                              cursorWidth: 1,
                              style: TextStyle(fontSize: 13.5.sp),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                      GetBuilder<HiveController>(
                        builder: (controller) {
                          return Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 10.w),
                            child: InkWell(
                              onTap: () {
                                visible = !visible;
                                hiveController.update();
                              },
                              child: Icon(
                                Icons.visibility,
                                color: visible == false
                                    ? Colors.grey[500]
                                    : Colors.grey.shade700,
                                size: 20.sp,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (SecurityController.SecurityData.get("gym").password ==
                            prev_password.text &&
                        new_password.text == confirmed_password.text) {
                      SecurityController.push_secured_data(
                          "gym", new_password.text);
                      print(
                          SecurityController.SecurityData.get("gym").password);
                      Get.back();
                    } else if (SecurityController.SecurityData.get("gym")
                                .password !=
                            prev_password.text &&
                        new_password.text == confirmed_password.text) {
                      logincheck(Text(
                        "your current password is not correct",
                        style: TextStyle(color: Colors.red.shade700),
                      ));
                    } else if (SecurityController.SecurityData.get("gym")
                                .password ==
                            prev_password.text &&
                        new_password != confirmed_password) {
                      print(new_password);
                      print(confirmed_password);

                      logincheck(Text(
                        "your new password doesn't match",
                        style: TextStyle(color: Colors.red.shade700),
                      ));
                    } else {
                      logincheck(Text(
                        "Check your passwords",
                        style: TextStyle(color: Colors.red.shade700),
                      ));
                    }
                    SecurityController.update();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 35.h),
                    width: 106.w,
                    height: 38.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFC7C7C7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.sp,
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 25.h),
                    child: GetBuilder<Security>(
                      builder: (controller) {
                        return widget;
                      },
                    ))
              ],
            ),
          )),
    );
  }
}
