import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voting/routes/app_routes.dart';
import 'package:voting/views/admin/home.dart';
import 'package:voting/views/user/home_screen.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? userData;
  RxBool isLoading = false.obs;
  RxString? selectedProvince = "".obs;
  RxString? selectedDivision = "".obs;
  RxString? selectedDistrict = "".obs;
  RxString? selectedTehsil = "".obs;
  String? selectedParty;
  RxBool isObsure = true.obs;

  // RegisterCandidate
  late TextEditingController nameController;
  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController mobilenoController;
  late TextEditingController cnicnoController;
  late TextEditingController dobController;
  late TextEditingController addressController;

  //Voting
  DateTime date = DateTime.now();
  late TextEditingController selectedDate;

  // Divisions
  List<String> divisions = [
    "Banbhore",
    "Hyderabad",
    "Karachi",
    "Larkana",
    "Mirpurkhas",
    "Sukkur",
    "Shaheed Benazir Abad"
  ];

  Map<String, List<String>> districts = {
    "Hyderabad": [
      "Dadu",
      "Hyderabad",
      "Jamshoro",
      "Matiari",
      "Tando Allahyar",
      "Tando Muhammad Khan"
    ],
    "Bandhore": [""],
    "Karachi": [""],
    "Larkana": [""],
    "Mirpurkhas": [""],
    "Sukkur": [""],
    "Shaheed Benazir Abad": [""],
  };

  Map<String, List<String>> tehsils = {
    "Hyderabad": [
      "Hyderabad City Tehsil",
      "Hyderabad Tehsil",
      "Latifabad Tehsil",
      "Qasimabad Tehsil",
    ],
    "Dadu": [
      'Dadu Tehsil',
      'Johi Tehsil',
      'Khairpur Nathan Shah Tehsil',
      'Mehar Tehsil',
    ],
    "Jamshoro": [
      'Kotri Tehsil',
      'Sehwan Tehsil',
      'Manjhand Tehsil',
      'Thana Bulla Khan Tehsil',
    ],
    "Matiari": [
      'Hala Tehsil',
      'Matiari Tehsil',
      'Saeedabad Tehsil',
    ],
    "Tando Allahyar": [
      'Chamber Tehsil',
      'Jhando Mari Tehsil',
      'Tando Allahyar Tehsil',
      'Nasarpur Tehsil',
    ],
    "Tando Muhammad Khan": [
      'Bulri Shah Karim Tehsil',
      'Tando Ghulam Hyder Tehsil',
      'Tando Mohammad Khan Tehsil',
    ],
  };

  //Result
  late TextEditingController selectDate;

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
    selectedDate = TextEditingController();
    selectDate = TextEditingController();
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
    selectedDate.dispose();
    selectDate.dispose();
    super.dispose();
  }

  void userLogin() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text)
            .then((outerValue) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(outerValue.user!.uid)
              .get()
              .then((value) {
            userData = value.data();
            if (userData!['role'] == "admin") {
              isLoading.value = false;
              Get.to(Home());
            } else if (userData!['role'] == "voter") {
              isLoading.value = false;
              Get.to(HomeScreen());
            } else {
              isLoading.value = false;
              Get.defaultDialog(
                radius: 6,
                title: "Alert",
                content: const Text("Candidate Cannot Login"),
                cancel: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Close"),
                ),
              );
            }
          });
        });
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
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

  Future<void> calendar(BuildContext context, bool isResult) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime(2101));
    if (picked != null) {
      isResult
          ? selectDate.text = DateFormat('dd-MM-yyyy').format(picked)
          : selectedDate.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }
}
