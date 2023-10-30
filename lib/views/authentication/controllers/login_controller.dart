import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/routes/app_routes.dart';
import 'package:voting/views/admin/home.dart';
import 'package:voting/views/user/home_screen.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? userData;
  RxBool isLoading = false.obs;


  //SignUp


  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void userLogin() {
    isLoading.value = true;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text)
        .then((outerValue) {
      FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: outerValue.user!.email)
          .where("isactive", isEqualTo: true)
          .get()
          .then((value) {
        userData = value.docs.first.data();
        if (userData!['role'] == "admin") {
          isLoading.value = false;
          Get.to( Home());
        } else {
          isLoading.value = false;
          Get.to(HomeScreen());
        }
      });
    });
  }

  void userSignOut() {
    FirebaseAuth.instance.signOut();
    userData!.clear();
    Get.offAndToNamed(AppRoutes.LOGIN);
  }
}
