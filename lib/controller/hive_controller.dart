import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tedjdesign/Boxes/All_Persons.dart';
import 'package:tedjdesign/Boxes/Blocked_Persons.dart';
import 'package:tedjdesign/Boxes/Expired_Persons.dart';

import '../Boxes/Active_Persons.dart';

class HiveController extends GetxController {
  late Box _myBox;
  late Persons number;
  late Box active_box;
  late Box state_box;
  late Box blocked_box;
  late Active active_person;
  late Box expired_box;
  late Expired inactive_person;
  late Blocked blocked_person;
  late Box cush_box;

  bool isblocked = false;
  bool isLoading = true;
  bool activeloading = true;
  bool expiredloading = true;
  bool bloackedloading = true;
  bool state = false;
  bool tapped = false;
  late DateTime starting_day;
  late DateTime end_day;
  late DateTime Blocked_day;
  List<dynamic> filtereddata = [];

  late ScrollController scrollController;

  XFile? imagepicker;
  @override
  void onInit() async {
    _myBox = await Hive.openBox<Persons>('myBox');
    active_box = await Hive.openBox<Active>("active");
    expired_box = await Hive.openBox<Expired>("expired");
    blocked_box = await Hive.openBox<Blocked>("blocked");
    scrollController = ScrollController();

    starting_day = DateTime.now();
    end_day = DateTime.now().add(Duration(days: 30));
    filtereddata = myBox.values.toList();
    super.onInit();
  }

  List<dynamic> get allPersons => _myBox.values.toList();

  Box get myBox => _myBox;
  void pushdata(
      String name,
      String phone,
      DateTime expDay,
      String? image,
      bool state,
      DateTime start,
      String plan,
      String paid,
      bool blocked,
      DateTime blockeddate) {
    myBox.put(
        phone,
        Persons(name, phone, expDay, image, state, start, plan, paid, blocked,
            blockeddate));
    update();
  }

  void deletedataBox(int i) {
    myBox.deleteAt(i);
    update();
  }

  void deletedata(int i, var del) {
    del.removeAt(i);
    update();
  }

  Persons readdata(int i) {
    number = myBox.getAt(i);
    return number;
  }

  Future<void> loading(int i) async {
    await readdata(i);
    await Future.delayed(Duration(milliseconds: 500));

    isLoading = false;
    update();
  }

  Future<void> activeload(int i) async {
    await ReadActivePerson(i);
    await Future.delayed(Duration(milliseconds: 500));
    activeloading = false;
    update();
  }

  bool isExpired(DateTime start, DateTime exp) {
    state = start.isAfter(exp);
    return state;
  }

  void readEndDate(DateTime day) {
    end_day = day;
    update();
  }

  Future<void> expiredload(int i) async {
    await ReadExpiredPerson(i);
    await Future.delayed(Duration(milliseconds: 500));
    expiredloading = false;
    update();
  }

  Future<void> blockedload(int i) async {
    await readblockdata(i);
    await Future.delayed(Duration(milliseconds: 500));
    bloackedloading = false;
    update();
  }

  void filterPersons(String query) {
    if (query == "") {
      filtereddata = myBox.values.toList();
    } else {
      filtereddata = myBox.values.toList().where((number) {
        var name = number.name;

        return name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  Future takephoto(ImageSource source) async {
    try {
      imagepicker = await ImagePicker().pickImage(source: source);
    } on PlatformException catch (e) {
      print(e);
    }
    update();
  }

  bool changestate(bool state) {
    update();
    return state;
  }

  Active ReadActivePerson(int i) {
    active_person = active_box.getAt(i);
    return active_person;
  }

  void PushActivePerson(String name, String phone, DateTime day,
      DateTime expDay, bool state, String? image, String plan, String paid) {
    active_box.put(
        phone, Active(name, phone, day, expDay, state, image, plan, paid));
    update();
  }

  void DeleteActivePerson(int i) {
    active_box.deleteAt(i);
    update();
  }

  void PushExpiredPerson(String name, String phone, DateTime day,
      DateTime expDay, bool state, String? image, String plan, String paid) {
    expired_box.put(
        phone, Expired(name, phone, day, expDay, state, image, plan, paid));
    update();
  }

  Expired ReadExpiredPerson(int i) {
    inactive_person = expired_box.getAt(i);
    return inactive_person;
  }

  void DeleteExpiredPerson(int i) {
    expired_box.deleteAt(i);
    update();
  }

  void isBlocked(bool blocked) {
    isblocked = blocked;
    update();
  }

  void pushblockdata(String name, String phone, DateTime blockeddate,
      DateTime expDay, String? image, String plan, String paid) {
    blocked_box.put(
        phone, Blocked(name, phone, blockeddate, expDay, image, plan, paid));
    update();
  }

  Blocked readblockdata(int i) {
    return blocked_box.getAt(i);
  }

  void deleteblocked(String key) {
    blocked_box.delete(key);
    update();
  }

  void deleteblockedindex(int index) {
    blocked_box.deleteAt(index);
    update();
  }
}
