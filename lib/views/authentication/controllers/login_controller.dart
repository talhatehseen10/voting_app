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
    "Banbhore": [
      "Badin",
      "Sujawal",
      "Thatta",
    ],
    "Karachi": [
      "Karachi Central",
      "Karachi East",
      "Karachi South",
      "Karachi West",
      "Korangi",
      "Malir",
      "Keamari"
    ],
    "Larkana": [
      "Jacobabad",
      "Kashmore",
      "Larkana",
      "Qambar-Shahdadkot",
      "Shikarpur"
    ],
    "Mirpurkhas": [
      "Mirpur Khas",
      "Tharparkar",
      "Umerkot",
    ],
    "Sukkur": [
      "Ghotki",
      "Khairpur Mirs",
      "Sukkur",
    ],
    "Shaheed Benazir Abad": [
      "Naushahro Feroze",
      "Shaheed Benazir Abad",
      "Sanghar",
    ],
  };

  Map<String, List<String>> tehsils = {
    "Hyderabad": [
      "Hyderabad City",
      "Hyderabad",
      "Latifabad",
      "Qasimabad",
    ],
    "Dadu": [
      'Dadu',
      'Johi',
      'Khairpur Nathan Shah',
      'Mehar',
    ],
    "Jamshoro": [
      'Kotri',
      'Sehwan',
      'Manjhand',
      'Thana Bulla Khan',
    ],
    "Matiari": [
      'Hala',
      'Matiari',
      'Saeedabad',
    ],
    "Tando Allahyar": [
      'Chamber',
      'Jhando Mari',
      'Tando Allahyar',
      'Nasarpur',
    ],
    "Tando Muhammad Khan": [
      'Bulri Shah Karim',
      'Tando Ghulam Hyder',
      'Tando Mohammad Khan',
    ],
    "Badin": [
      'Badin',
      'Khoski',
      'Matli',
      'Shaheed Fazil Rahu',
      'Talhar',
      'Tando Bago',
    ],
    "Sujawal": [
      'Jati',
      'Kharo Chan',
      'Mirpur Bathoro',
      'Shah Bandar',
      'Sujawal',
    ],
    "Thatta": [
      'Ghorabari',
      'Keti Bunder',
      'Mirpur Sakro',
      'Thatta',
    ],
    "Karachi Central": [
      'Gulberg Town',
      'Liaquatabad Town',
      'New Karachi Town',
      'North Nazimabad Town',
      'Nazimabad',
    ],
    "Karachi East": [
      'Gulistan-e-Jouhar (G-E-J)',
      'Gulshan Town',
      'Jamshed Town',
      'Ferozabad',
      'Gulshan-E-Iqbal',
      'Gulzar-E-Hijri',
    ],
    "Karachi South": [
      'Lyari Town',
      'Saddar Town',
      'Aram Bagh',
      'Civil Line',
      'Garden',
    ],
    "Karachi West": [
      'Orangi Town',
      'Manghopir',
      'Maripur',
      'Mominabad',
      'Ittehad Town',
      'Baldia Town',
    ],
    "Korangi": [
      'Korangi Town',
      'Landhi Town',
      'Shah Faisal Town',
      'Model Colony',
    ],
    "Malir": [
      'Bin Qasim Town',
      'Gadap Town',
      'Malir Town',
      'Jinnah',
      'Ibrahim Hyderi',
      'Murad Memon',
      'Shah Murad',
    ],
    "Keamari": [
      "Keamari Town",
      "Baldia Town",
      "S.I.T.E. Town",
      "Karachi Fish Harbour"
    ],
    "Jacobabad": [
      'Garhi Khairo',
      'Jacobabad',
      'Thul',
    ],
    "Kashmore": [
      'Kandhkot',
      'Kashmore',
      'Tangwani',
    ],
    "Larkana": [
      'Bakrani',
      'Dokri',
      'Larkana',
      'Ratodero',
    ],
    "Qambar-Shahdadkot": [
      'Mirokhan',
      'Nasirabad',
      'Qambar',
      'Qubo Saeed Khan',
      'Shahdadkot',
      'Sijawal Junejo',
      'Warah',
    ],
    "Shikarpur": [
      "Garhi Yasin",
      "Khanpur",
      "Lakhi",
      "Shikarpur",
    ],
    "Mirpur Khas": [
      'Digri',
      'Jhuddo',
      'Kot Ghulam Muhammad',
      'Mirpur Khas',
      'Shujabad',
      'Sindhri',
    ],
    "Tharparkar": [
      'Chachro',
      'Dahli',
      'Diplo',
      'Kaloi',
      'Islmakot',
      'Mithi',
      'Nagarparkar'
    ],
    "Umerkot": [
      "Kunri",
      "Pithoro",
      "Samaro",
      "Umerkot",
    ],
    "Ghotki": [
      'Daharki',
      'Ghotki',
      'Khangarh (Khanpur)',
      'Mirpur Mathelo',
      'Ubauro'
    ],
    "Khairpur Mirs": [
      'Faiz Ganj',
      'Gambat',
      'Khairpur Mirs',
      'Kingri',
      'Kot Diji',
      'Nara',
      'Sobho Dero',
      'Thari Mirwah',
    ],
    "Sukkur": [
      'New Sukkur',
      'Pano Aqil',
      'Rohri',
      'Salehpat',
      'Sukkur',
    ],
    'Naushahro Feroze': [
      "Bhiria",
      "Kandiaro",
      "Mehrabpur",
      "Moro",
      "Naushahro Feroze"
    ],
    "Shaheed Benazir Abad": [
      'Daulatpur (now Kazi Ahmed)',
      'Daur (2004)',
      'Nawabshah (1907)',
      'Sakrand (1858)'
    ],
    "Sanghar": [
      'Jam Nawaz Ali',
      'Khipro',
      'Sanghar',
      'Shahdadpur',
      'Sinjhoro',
      'Tando Adam Khan',
    ]
  };

  //Result
  late TextEditingController selectDate;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
              Get.to(() => Home());
            } else if (userData!['role'] == "voter") {
              isLoading.value = false;
              if (userData!["status"] == "accepted") {
                Get.to(() => HomeScreen());
              } else {
                isLoading.value = false;
                Get.snackbar(
                  "In Process",
                  "Account not verified.",
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: Colors.red,
                    size: 24,
                  ),
                );
              }
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
