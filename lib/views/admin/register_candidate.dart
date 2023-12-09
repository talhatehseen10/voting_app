import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/widgets/custom_dropdown_button.dart';
import 'package:voting/widgets/custom_textfield_with_title.dart';

class RegisterCandidate extends GetView<LoginController> {
  const RegisterCandidate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Candidate Registeration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomTextfieldWithTitle(
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
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
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.phone,
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
                  keyboardType: TextInputType.number,
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
                  controller: controller.addressController,
                  keyboardType: TextInputType.number,
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
                CustomTextfieldWithTitle(
                  controller: controller.dobController,
                  keyboardType: TextInputType.datetime,
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
                const SizedBox(
                  height: 20,
                ),
                CustomDropDownButton(
                  validator: (val) {
                    if (val == null) {
                      return "Required";
                    }
                    return null;
                  },
                  isListOfString: true,
                  hintText: "Political Party",
                  fillColor: Colors.grey.shade200,
                  items: const ["PTI", "PMLN", "PPP", "JI"],
                  onChnaged: (val) {
                    controller.selectedParty = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDropDownButton(
                  validator: (val) {
                    if (val == null) {
                      return "Required";
                    }
                    return null;
                  },
                  isListOfString: true,
                  hintText: "Province",
                  fillColor: Colors.grey.shade200,
                  items: const ["Sindh"],
                  onChnaged: (val) {
                    controller.selectedProvince!.value = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDropDownButton(
                  validator: (val) {
                    if (val == null) {
                      return "Required";
                    }
                    return null;
                  },
                  isListOfString: true,
                  hintText: "Division",
                  fillColor: Colors.grey.shade200,
                  items: controller.divisions,
                  onChnaged: (val) {
                    controller.selectedDivision!.value = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => controller.selectedDivision!.value.isEmpty
                      ? const SizedBox()
                      : CustomDropDownButton(
                          validator: (val) {
                            if (val == null) {
                              return "Required";
                            }
                            return null;
                          },
                          isListOfString: true,
                          hintText: "District",
                          fillColor: Colors.grey.shade200,
                          items: controller
                              .districts[controller.selectedDivision!.value],
                          onChnaged: (val) {
                            controller.selectedDistrict!.value = val;
                          },
                        ),
                ),
                Obx(
                  () => controller.selectedDistrict!.value != "Hyderabad" &&
                          controller.selectedDistrict!.value.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDropDownButton(
                            validator: (val) {
                              if (val == null) {
                                return "Required";
                              }
                              return null;
                            },
                            isListOfString: true,
                            hintText: "Tehsils",
                            fillColor: Colors.grey.shade200,
                            items: controller
                                .tehsils[controller.selectedDistrict!.value],
                            onChnaged: (val) {
                              controller.selectedTehsil!.value = val;
                            },
                          ),
                        ),
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
                                        password: "111222")
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
                                      "password": "111222",
                                      "dob": controller.dobController.text,
                                      "address":
                                          controller.addressController.text,
                                      "party": "",
                                      "profile_picture": "",
                                      "isactive": true,
                                      "political_party":
                                          controller.selectedParty,
                                      "division":
                                          controller.selectedDivision!.value,
                                      "district":
                                          controller.selectedDistrict!.value,
                                      "tehsil":
                                          controller.selectedTehsil!.value,
                                      "role": "candidate",
                                      "status": "accepted"
                                    }).then((value) {
                                      controller.isLoading.value = false;
                                      if (value.id.isNotEmpty) {
                                        controller.registerEmailController
                                            .clear();
                                        controller.registerPasswordController
                                            .clear();
                                        controller.nameController.clear();
                                        controller.mobilenoController.clear();
                                        controller.cnicnoController.clear();
                                        controller.dobController.clear();
                                        controller.addressController.clear();
                                        controller.selectedProvince = null;
                                        controller.selectedParty = null;
                                        controller.selectedDivision = null;
                                        controller.selectedDistrict = null;
                                        controller.selectedTehsil = null;
                                        Get.snackbar(
                                          "Successful",
                                          "Candidate Added Sucessfully",
                                          icon: const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.green,
                                            size: 24,
                                          ),
                                        );
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
