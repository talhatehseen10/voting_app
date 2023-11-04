import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/user/profile_screen.dart';

class VoterListScreen extends StatefulWidget {
  const VoterListScreen({super.key});

  @override
  State<VoterListScreen> createState() => _VoterListScreenState();
}

class _VoterListScreenState extends State<VoterListScreen> {
  final bool isChecked = false;
  String status = "accepted";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        title: const Text('Voters List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        status = "accepted";
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade100,
                      ),
                      child: const Center(
                        child: Text(
                          "Accepted",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        status = "pending";
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        status = "rejected";
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Rejected",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("role", isEqualTo: "voter")
                    .where("status", isEqualTo: status)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            Get.to(ProfileScreen(
                              data: snapshot.data!.docs[index].data(),
                            ));
                          },
                          leading: CircleAvatar(
                            radius: 20,
                            child: Text(snapshot.data!.docs[index]["name"][0]),
                          ),
                          title: Text(snapshot.data!.docs[index]["name"]),
                          subtitle: Text(snapshot.data!.docs[index]["cnic"]),
                          trailing: status == "pending"
                              ? SizedBox(
                                  width: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .where("email",
                                                  isEqualTo: snapshot.data!
                                                      .docs[index]["email"])
                                              .get()
                                              .then((value) {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(value.docs.first.id)
                                                .set({
                                              "name": value.docs.first["name"],
                                              "email":
                                                  value.docs.first["email"],
                                              "mobileno":
                                                  value.docs.first["mobileno"],
                                              "cnic": value.docs.first["cnic"],
                                              "password":
                                                  value.docs.first["password"],
                                              "dob": value.docs.first["dob"],
                                              "address":
                                                  value.docs.first["address"],
                                              "party":
                                                  value.docs.first["party"],
                                              "profile_picture": value.docs
                                                  .first["profile_picture"],
                                              "isactive":
                                                  value.docs.first["isactive"],
                                              "role": value.docs.first["role"],
                                              "status": "accepted"
                                            });
                                          });
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .where("email",
                                                  isEqualTo: snapshot.data!
                                                      .docs[index]["email"])
                                              .get()
                                              .then((value) {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(value.docs.first.id)
                                                .set({
                                              "status": "accepted",
                                            });
                                          });
                                        },
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
