import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tedjdesign/Boxes/Active_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tedjdesign/pages/Blocked.dart';
import 'package:tedjdesign/pages/Expired.dart';
import 'package:tedjdesign/pages/add_member.dart';
import 'package:tedjdesign/pages/cash.dart';

import '../controller/hive_controller.dart';
import 'Active.dart';
import 'All.dart'; // Import the intl package

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveController hiveController = Get.find();

    void start() async {
      for (int i = hiveController.active_box.length - 1; i >= 0; i--) {
        if (hiveController.isExpired(DateTime.now(),
                hiveController.ReadActivePerson(i).experation) ==
            false) {
        } else if (hiveController.isExpired(DateTime.now(),
                hiveController.ReadActivePerson(i).experation) ==
            true) {
          hiveController.expired_box.add(Expired(
              hiveController.ReadActivePerson(i).name,
              hiveController.ReadActivePerson(i).phone,
              DateTime.now(),
              hiveController.ReadActivePerson(i).experation,
              true,
              hiveController.ReadActivePerson(i).image,
              hiveController.ReadActivePerson(i).plan,
              hiveController.ReadActivePerson(i).paid));

          hiveController.DeleteActivePerson(i);
        }
      }

      for (int j = hiveController.expired_box.length - 1; j >= 0; j--) {
        if (hiveController.isExpired(DateTime.now(),
                hiveController.ReadExpiredPerson(j).experation) ==
            false) {
          hiveController.active_box.add(Active(
              hiveController.ReadExpiredPerson(j).name,
              hiveController.ReadExpiredPerson(j).phone,
              DateTime.now(),
              hiveController.ReadExpiredPerson(j).experation,
              false,
              hiveController.ReadExpiredPerson(j).image,
              hiveController.ReadExpiredPerson(j).plan,
              hiveController.ReadExpiredPerson(j).paid));
          hiveController.DeleteExpiredPerson(j);
        } else if (hiveController.isExpired(DateTime.now(),
                hiveController.ReadExpiredPerson(j).experation) ==
            true) {}
      }
      await Future.delayed(Duration(seconds: 1));
    }

    Future<void> Classify() async {
      return start();
    }

    bool all = true, expired = false, blocked = false, active = false;
    DateTime Today = DateTime.now();
    return Scaffold(
        backgroundColor: Color(0xFFD9D9D9),
        body: RefreshIndicator(
          onRefresh: Classify,
          color: Colors.black,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            width: 1.sw,
                            height: 250.h,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF232020),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${DateFormat.EEEE().format(Today)},',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontFamily: 'Helvetica Light',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: DateFormat.MMMM()
                                              .format(Today)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontFamily: 'Helvetica Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: DateFormat.d().format(Today),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ',',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontFamily: 'Helvetica Light',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${DateFormat.y().format(Today)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.sp,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 40.h),
                                        width: 281.56.w,
                                        height: 34.h,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0.50,
                                                color: Color(0xFFD9D9D9)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w, right: 3.w),
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.white,
                                                size: 22.sp,
                                              ),
                                            ),
                                            Container(
                                              width: 210.w,
                                              margin:
                                                  EdgeInsets.only(bottom: 5.h),
                                              child: TextField(
                                                onChanged: (value) {
                                                  if (all == true) {
                                                    hiveController
                                                        .filterPersons(value);
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white),
                                                cursorColor: Colors.white,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          35)),
                                                          child: GetBuilder<
                                                              HiveController>(
                                                            builder:
                                                                (controller) {
                                                              return Container(
                                                                width: 100.w,
                                                                height: 200.h,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  color: Color(
                                                                      0xFFD9D9D9),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            33),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.only(
                                                                          top: 15
                                                                              .h,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                all = hiveController.changestate(true);
                                                                                active = hiveController.changestate(false);
                                                                                expired = hiveController.changestate(false);
                                                                                blocked = hiveController.changestate(false);
                                                                                hiveController.activeloading = true;
                                                                                hiveController.expiredloading = true;
                                                                                hiveController.bloackedloading = true;
                                                                              },
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 25.h, left: 50.w),
                                                                                child: Icon(
                                                                                  all == true ? Icons.circle : Icons.circle_outlined,
                                                                                  color: Colors.black,
                                                                                  size: 11.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: 25.h, left: 25.w),
                                                                              child: Text(
                                                                                'All',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Helvetica',
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: 25.h, left: 100.w),
                                                                              child: Text(
                                                                                '(${hiveController.myBox.length})',
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF686666),
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Helvetica',
                                                                                  fontWeight: FontWeight.w400,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              all = hiveController.changestate(false);
                                                                              active = hiveController.changestate(true);
                                                                              expired = hiveController.changestate(false);
                                                                              blocked = hiveController.changestate(false);
                                                                              hiveController.isLoading = true;
                                                                              hiveController.expiredloading = true;
                                                                              hiveController.bloackedloading = true;
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.only(top: 17.h, left: 50.w),
                                                                              child: Icon(
                                                                                active == true ? Icons.circle : Icons.circle_outlined,
                                                                                color: Colors.black,
                                                                                size: 11.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 25.w),
                                                                            child:
                                                                                Text(
                                                                              'Active',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 77.w),
                                                                            child:
                                                                                Text(
                                                                              '(${hiveController.active_box.length})',
                                                                              style: TextStyle(
                                                                                color: Color(0xFF686666),
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              all = hiveController.changestate(false);
                                                                              active = hiveController.changestate(false);
                                                                              expired = hiveController.changestate(true);
                                                                              blocked = hiveController.changestate(false);
                                                                              hiveController.isLoading = true;
                                                                              hiveController.activeloading = true;
                                                                              hiveController.bloackedloading = true;
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.only(top: 17.h, left: 50.w),
                                                                              child: Icon(
                                                                                expired == true ? Icons.circle : Icons.circle_outlined,
                                                                                color: Colors.black,
                                                                                size: 11.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 25.w),
                                                                            child:
                                                                                Text(
                                                                              'Expired',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 70.w),
                                                                            child:
                                                                                Text(
                                                                              '(${hiveController.expired_box.length})',
                                                                              style: TextStyle(
                                                                                color: Color(0xFF686666),
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              all = hiveController.changestate(false);
                                                                              active = hiveController.changestate(false);
                                                                              expired = hiveController.changestate(false);
                                                                              blocked = hiveController.changestate(true);
                                                                              hiveController.isLoading = true;
                                                                              hiveController.expiredloading = true;
                                                                              hiveController.expiredloading = true;
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.only(top: 17.h, left: 50.w),
                                                                              child: Icon(
                                                                                blocked == true ? Icons.circle : Icons.circle_outlined,
                                                                                color: Colors.black,
                                                                                size: 11.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 25.w),
                                                                            child:
                                                                                Text(
                                                                              'Blocked',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 17.h, left: 68.w),
                                                                            child:
                                                                                Text(
                                                                              '(${hiveController.blocked_box.length})',
                                                                              style: TextStyle(
                                                                                color: Color(0xFF686666),
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Helvetica',
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ]),
                                                              );
                                                            },
                                                          ));
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.menu,
                                                  size: 20.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const AddPerson(),
                                              transition: Transition.upToDown,
                                              duration: const Duration(
                                                  milliseconds: 300));
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 38.h, left: 20.w),
                                          child: Icon(
                                            Icons.person_add_alt_1,
                                            color: Colors.white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      height: 40.h,
                                      margin: EdgeInsets.only(top: 15.h),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GetBuilder<HiveController>(
                                                    builder: (controller) {
                                                      return InkWell(
                                                        onTap: () {
                                                          all = hiveController
                                                              .changestate(
                                                                  true);
                                                          active =
                                                              hiveController
                                                                  .changestate(
                                                                      false);
                                                          expired =
                                                              hiveController
                                                                  .changestate(
                                                                      false);
                                                          blocked =
                                                              hiveController
                                                                  .changestate(
                                                                      false);
                                                          hiveController
                                                                  .activeloading =
                                                              true;
                                                          hiveController
                                                                  .expiredloading =
                                                              true;
                                                          hiveController
                                                                  .bloackedloading =
                                                              true;
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 55.w,
                                                          ),
                                                          child: Text(
                                                            'All',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFD9D9D9),
                                                              fontSize:
                                                                  all == true
                                                                      ? 16.sp
                                                                      : 13.sp,
                                                              fontFamily:
                                                                  'Helvetica',
                                                              fontWeight: all ==
                                                                      true
                                                                  ? FontWeight
                                                                      .w700
                                                                  : FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  GetBuilder<HiveController>(
                                                      builder: (controller) {
                                                    if (all == true) {
                                                      return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 5.w,
                                                          ),
                                                          child: Icon(
                                                            Icons.circle,
                                                            color: Colors.white,
                                                            size: 6.sp,
                                                          ));
                                                    } else
                                                      return Container();
                                                  }),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GetBuilder<HiveController>(
                                                  builder: (controller) {
                                                    return InkWell(
                                                      onTap: () {
                                                        all = hiveController
                                                            .changestate(false);
                                                        active = hiveController
                                                            .changestate(true);
                                                        expired = hiveController
                                                            .changestate(false);
                                                        blocked = hiveController
                                                            .changestate(false);
                                                        hiveController
                                                            .isLoading = true;
                                                        hiveController
                                                                .expiredloading =
                                                            true;
                                                        hiveController
                                                                .bloackedloading =
                                                            true;
                                                      },
                                                      child: Text(
                                                        'Active',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFD9D9D9),
                                                          fontSize:
                                                              active == true
                                                                  ? 16.sp
                                                                  : 13.sp,
                                                          fontFamily:
                                                              'Helvetica Light',
                                                          fontWeight: active ==
                                                                  true
                                                              ? FontWeight.w700
                                                              : FontWeight.w400,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                GetBuilder<HiveController>(
                                                    builder: (controller) {
                                                  if (active == true) {
                                                    return Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5.w),
                                                        child: Icon(
                                                          Icons.circle,
                                                          color: Colors.white,
                                                          size: 6.sp,
                                                        ));
                                                  } else
                                                    return Container();
                                                }),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GetBuilder<HiveController>(
                                                  builder: (controller) {
                                                    return InkWell(
                                                      onTap: () {
                                                        all = hiveController
                                                            .changestate(false);
                                                        active = hiveController
                                                            .changestate(false);
                                                        expired = hiveController
                                                            .changestate(true);
                                                        blocked = hiveController
                                                            .changestate(false);
                                                        hiveController
                                                            .isLoading = true;
                                                        hiveController
                                                                .activeloading =
                                                            true;
                                                        hiveController
                                                                .bloackedloading =
                                                            true;
                                                      },
                                                      child: Container(
                                                        child: Text(
                                                          'Expired',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFD9D9D9),
                                                            fontSize:
                                                                expired == true
                                                                    ? 16.sp
                                                                    : 13.sp,
                                                            fontFamily:
                                                                'Helvetica Light',
                                                            fontWeight:
                                                                expired == true
                                                                    ? FontWeight
                                                                        .w700
                                                                    : FontWeight
                                                                        .w400,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                GetBuilder<HiveController>(
                                                    builder: (controller) {
                                                  if (expired == true) {
                                                    return Container(
                                                        child: Icon(
                                                      Icons.circle,
                                                      color: Colors.white,
                                                      size: 6.sp,
                                                    ));
                                                  } else
                                                    return Container();
                                                }),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GetBuilder<HiveController>(
                                                  builder: (controller) {
                                                    return InkWell(
                                                      onTap: () {
                                                        all = hiveController
                                                            .changestate(false);
                                                        active = hiveController
                                                            .changestate(false);
                                                        expired = hiveController
                                                            .changestate(false);
                                                        blocked = hiveController
                                                            .changestate(true);
                                                        hiveController
                                                            .isLoading = true;
                                                        hiveController
                                                                .expiredloading =
                                                            true;
                                                        hiveController
                                                                .activeloading =
                                                            true;
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 55.w),
                                                        child: Text(
                                                          'Blocked',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFD9D9D9),
                                                            fontSize:
                                                                blocked == true
                                                                    ? 16.sp
                                                                    : 13.sp,
                                                            fontFamily:
                                                                'Helvetica Light',
                                                            fontWeight:
                                                                blocked == true
                                                                    ? FontWeight
                                                                        .w700
                                                                    : FontWeight
                                                                        .w400,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                GetBuilder<HiveController>(
                                                    builder: (controller) {
                                                  if (blocked == true) {
                                                    return Container(
                                                        margin: EdgeInsets.only(
                                                            right: 58.w),
                                                        child: Icon(
                                                          Icons.circle,
                                                          color: Colors.white,
                                                          size: 6.sp,
                                                        ));
                                                  } else
                                                    return Container();
                                                }),
                                              ],
                                            ),
                                          ]))
                                ])),
                        GetBuilder<HiveController>(
                          builder: (controller) {
                            return Container(
                              color: Color(0xFFD9D9D9),
                              width: 390.w,
                              height: hiveController.myBox.length <= 3
                                  ? 720.h
                                  : ((1050.h) * hiveController.myBox.length) /
                                      5,
                              child: GetBuilder<HiveController>(
                                builder: (HiveController controller) {
                                  if (all == true) {
                                    if (hiveController.isLoading == false) {
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            hiveController.filtereddata.length,
                                        itemBuilder: (context, index) {
                                          return AllPersons(index: index);
                                        },
                                      );
                                    } else {
                                      for (int i = 0;
                                          i < hiveController.myBox.length;
                                          i++) {
                                        hiveController.loading(i);
                                      }
                                      return Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.only(top: 50.h),
                                          width: 50.w,
                                          height: 50.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 3,
                                          ));
                                    }
                                  } else if (active == true) {
                                    if (hiveController.activeloading == false) {
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            hiveController.active_box.length,
                                        itemBuilder: (context, index) {
                                          return ActivePersons(index: index);
                                        },
                                      );
                                    } else {
                                      for (int i = 0;
                                          i < hiveController.active_box.length;
                                          i++) {
                                        hiveController.activeload(i);
                                      }
                                      return Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.only(top: 50.h),
                                          width: 50.w,
                                          height: 50.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 3,
                                          ));
                                    }
                                  } else if (expired == true) {
                                    if (hiveController.expiredloading ==
                                        false) {
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            hiveController.expired_box.length,
                                        itemBuilder: (context, index) {
                                          return ExpiredPersons(index: index);
                                        },
                                      );
                                    } else {
                                      for (int i = 0;
                                          i < hiveController.expired_box.length;
                                          i++) {
                                        hiveController.expiredload(i);
                                      }
                                      return Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.only(top: 50.h),
                                          width: 50.w,
                                          height: 50.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 3,
                                          ));
                                    }
                                  } else if (hiveController.bloackedloading ==
                                      false) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          hiveController.blocked_box.length,
                                      itemBuilder: (context, index) {
                                        return BlockedPersons(index: index);
                                      },
                                    );
                                  } else {
                                    for (int i = 0;
                                        i < hiveController.blocked_box.length;
                                        i++) {
                                      hiveController.blockedload(i);
                                    }
                                    return Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(top: 50.h),
                                        width: 50.w,
                                        height: 50.h,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 3,
                                        ));
                                  }
                                },
                              ),
                            );
                          },
                        )
                      ],
                    )),
                  ),
                ],
              ),
              Positioned(
                  top: 725.h,
                  child: Container(
                    margin: EdgeInsets.only(left: 32.w),
                    width: 330.w,
                    height: (52.h),
                    decoration: ShapeDecoration(
                      color: Color(0xFF232121),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 95.w,
                            child: Hero(
                              tag: "1",
                              child: Icon(
                                Icons.home_filled,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: 95.w,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => CashPage(),
                                    transition: Transition.rightToLeft,
                                    duration: Duration(milliseconds: 400));
                              },
                              child: Hero(
                                tag: "2",
                                child: Icon(Icons.attach_money,
                                    color: Colors.grey.shade600, size: 30.sp),
                              ),
                            ),
                          )
                        ]),
                  ))
            ],
          ),
        ));
  }
}
