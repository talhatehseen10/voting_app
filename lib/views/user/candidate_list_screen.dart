import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/admin/register_candidate.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/views/user/profile_screen.dart';

class CandidateListScreen extends StatelessWidget {
  CandidateListScreen({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: loginController.userData!["role"] == "admin"
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => const RegisterCandidate());
              },
              child: const Icon(
                Icons.person_add_outlined,
              ),
            )
          : const SizedBox(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: const Text('Candiates List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("role", isEqualTo: "candidate")
            .where("isactive", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Get.to(
                        ProfileScreen(data: snapshot.data!.docs[index].data()));
                  },
                  onLongPress: () {
                    if (loginController.userData!["role"] == "admin") {
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: "Delete",
                          content: const Text("Are you sure?"),
                          actions: [
                            Obx(
                              () => loginController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const SizedBox(),
                            ),
                            Obx(
                              () => loginController.isLoading.value
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                            ),
                            Obx(
                              () => loginController.isLoading.value
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      onPressed: () async {
                                        loginController.isLoading.value = true;
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete()
                                            .then((value) {});
                                        UserCredential user = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: snapshot
                                                    .data!.docs[index]['email'],
                                                password: snapshot.data!
                                                    .docs[index]['password']);

                                        user.user!.delete();
                                        loginController.isLoading.value = true;

                                        Get.back();
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: loginController
                                                    .userData!["email"],
                                                password: loginController
                                                    .userData!["password"]);
                                      },
                                      child: const Text("Delete"),
                                    ),
                            ),
                          ]);
                    }
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    child: Text(snapshot.data!.docs[index]["name"][0]),
                  ),
                  title: Text("${snapshot.data!.docs[index]['name']}"),
                  subtitle:
                      Text("${snapshot.data!.docs[index]['political_party']}"),
                  trailing: snapshot.data!.docs[index]['political_party'] == ""
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              "assets/${snapshot.data!.docs[index]['political_party']}.png"),
                        ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
