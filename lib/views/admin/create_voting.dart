import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/widgets/common_text_field.dart';

class CreateVoting extends StatelessWidget {
  CreateVoting({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Voting"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: loginController.selectedDate,
                    lableText: "Select Date",
                    readOnly: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginController.calendar(context, false);
                      },
                      child: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: TextEditingController(text: "09:00 AM"),
                    lableText: "Start Time",
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.timer,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: TextEditingController(text: "05:00 PM"),
                    lableText: "Start Time",
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.timer,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Get.defaultDialog(
                      title: "Creating Polls",
                      content: const CircularProgressIndicator());
                  FirebaseFirestore.instance
                      .collection("votes")
                      .doc(loginController.selectedDate.text)
                      .get()
                      .then((value) {
                    if (value.exists) {
                      Get.back();
                      Get.snackbar("Alert", "Election Already Exist",
                          icon: const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ));
                    } else {
                      try {
                        FirebaseFirestore.instance
                            .collection("votes")
                            .doc(loginController.selectedDate.text)
                            .set({
                          "start_time": "09:00 AM",
                          "end_time": "05:00 PM",
                          "votes": [],
                          "votes_to": [],
                          "isStopped": true,
                          "date": loginController.selectedDate.text,
                        });
                        Get.back();
                        Get.snackbar(
                          "Congarts",
                          "Successfully created",
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        );
                      } on FirebaseException catch (e) {
                        Get.back();

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
                  });
                },
                child: const Text("Create Election"))
          ],
        ),
      ),
    );
  }
}
