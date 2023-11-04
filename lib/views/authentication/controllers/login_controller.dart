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

  // RegisterCandidate
  late TextEditingController nameController;
  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController mobilenoController;
  late TextEditingController cnicnoController;
  late TextEditingController dobController;
  late TextEditingController addressController;

  //SignUp

  @override
  void onInit() {
    emailController = TextEditingController(text: "admin@gmail.com");
    passwordController = TextEditingController(text: "111222");
    nameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    mobilenoController = TextEditingController();
    cnicnoController = TextEditingController();
    dobController = TextEditingController();
    addressController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    nameController.dispose();
    mobilenoController.dispose();
    cnicnoController.dispose();
    dobController.dispose();
    addressController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.dispose();
  }

  void userLogin() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
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
            Get.to(Home());
          } else {
            isLoading.value = false;
            Get.to(HomeScreen());
          }
        });
      });
    } else {
      Get.defaultDialog(
        content: const Text("Fields Required"),
        cancel: SizedBox(
          height: 40,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Close"),
          ),
        ),
      );
    }
  }

  void userSignOut() {
    FirebaseAuth.instance.signOut();
    userData!.clear();
    Get.offAllNamed(AppRoutes.LOGIN);
    // Get.offAndToNamed(AppRoutes.LOGIN);
  }
}
