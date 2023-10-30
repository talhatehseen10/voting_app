import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/widgets/custom_textfield_with_title.dart';

class SignUpScreen extends GetView<LoginController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Candidate"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfieldWithTitle(
                    controller: controller.nameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Name",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.registerEmailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Email",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.mobilenoController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Mobile No",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.cnicnoController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "CNIC",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.registerPasswordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Password",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.dobController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Date of Birth",
                    isObscureText: false,
                    title: '',
                  ),
                  CustomTextfieldWithTitle(
                    controller: controller.addressController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Address",
                    isObscureText: false,
                    title: '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 250,
                    child: Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                backgroundColor: Colors.black,
                                elevation: 2),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.isLoading.value = true;
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: controller
                                            .registerEmailController.text,
                                        password: controller
                                            .registerPasswordController.text)
                                    .then((value) {
                                  if (value.user!.email!.isNotEmpty) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .add({
                                      "name": controller.nameController.text,
                                      "email": controller
                                          .registerEmailController.text,
                                      "mobileno":
                                          controller.mobilenoController.text,
                                      "cnic": controller.cnicnoController.text,
                                      "password": controller
                                          .registerPasswordController.text,
                                      "dob": controller.dobController.text,
                                      "address":
                                          controller.addressController.text,
                                      "party": "",
                                      "profile_picture": "",
                                      "isactive": true,
                                      "role": "candidate",
                                    }).then((value) {
                                      controller.isLoading.value = false;
                                      if (value.id.isNotEmpty) {
                                        Get.snackbar(
                                          "Successful",
                                          "Candidate Added Sucessfully",
                                          icon: const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.green,
                                            size: 24,
                                          ),
                                        );
                                        Get.back();
                                        controller.registerEmailController
                                            .clear();
                                      }
                                    });
                                  } else {
                                    controller.isLoading.value = false;
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
