import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/widgets/custom_textfield_with_title.dart';

class SignupScreen extends GetView<LoginController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voter Registeration"),
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
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.isLoading.value = true;
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: controller
                                              .registerEmailController.text,
                                          password: controller
                                              .registerPasswordController.text)
                                      .then((outerValue) {
                                    controller.isLoading.value = false;

                                    if (outerValue.user!.email!.isNotEmpty) {
                                      FirebaseFirestore.instance
                                          .collection("users").doc(outerValue.user!.uid)
                                          .set({
                                        "name": controller.nameController.text,
                                        "email": controller
                                            .registerEmailController.text,
                                        "mobileno":
                                            controller.mobilenoController.text,
                                        "cnic":
                                            controller.cnicnoController.text,
                                        "password": controller
                                            .registerPasswordController.text,
                                        "dob": controller.dobController.text,
                                        "address":
                                            controller.addressController.text,
                                        "party": "",
                                        "profile_picture": "",
                                        "isactive": false,
                                        "role": "voter",
                                        "status": "pending"
                                      }).then((value) {
                                        if (true) {
                                          Get.snackbar(
                                            "Successful",
                                            "Voter Added Sucessfully",
                                            icon: const Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Colors.green,
                                              size: 24,
                                            ),
                                          );
                                          controller.registerEmailController
                                              .clear();
                                          controller.registerPasswordController
                                              .clear();
                                          controller.nameController.clear();
                                          controller.mobilenoController.clear();
                                          controller.cnicnoController.clear();
                                          controller.dobController.clear();
                                          controller.addressController.clear();
                                        }
                                      });
                                    } else {
                                      controller.isLoading.value = false;
                                    }
                                  });
                                } on FirebaseAuthException catch (e) {
                                  controller.isLoading.value = false;
                                  Get.snackbar(
                                    "Failed",
                                    e.code,
                                    icon: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  );
                                }
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
