import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase.dart';

class HomeController extends GetxController {
  List<dynamic> usersList = [];
  var name = '';
  var phoneNumber = '';
  var email = '';
  double reward = 0.00;

  // get user info
  getUserInfo() async {
    Future.delayed(const Duration(seconds: 5), () async {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.email)
          .get()
          .then((value) {
        name = value.get('userName');
        phoneNumber = value.get('phoneNumber');
        email = value.get('email');
        reward = value.get('reward');
      });
    });
    update();
  }

  getUsers() async {
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    usersList = querySnapshot.docs.map((doc) => doc.get('uid')).toList();
    update();
    debugPrint('Users......${usersList.toString()}');
  }

  @override
  void onReady() {
    getUsers();
    getUserInfo();
    super.onReady();
  }

  @override
  void onInit() {
    getUsers();
    getUserInfo();
    super.onInit();
  }
}
