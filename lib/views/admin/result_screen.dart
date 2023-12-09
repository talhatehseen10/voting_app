import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/views/user/profile_screen.dart';
import 'package:voting/widgets/common_text_field.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List data = [];
  List votes = List.filled(10, 0);
  bool isLoading = false;
  List candidates = [];
  LoginController loginController = Get.find<LoginController>();

  Future<String> countVote(String email) async {
    int count = 0;
    var data = await FirebaseFirestore.instance
        .collection("votes")
        .doc(loginController.selectDate.text)
        .get();
    for (int i = 0; i < data.get("votes_to").length; i++) {
      if (data.get("votes_to")[i] == email) {
        count++;
      }
    }
    setState(() {
      isLoading = false;
    });
    return "$count";
  }

  void getData() async {
    setState(() {
      data.clear();
      isLoading = true;
    });
    int index = 0;
    var temp = await FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "candidate")
        .where("isactive", isEqualTo: true)
        .get();
    for (var element in temp.docs) {
      String temp;
      temp = await countVote(element.data()["email"]);
      setState(() {
        data.add(element.data());
        data[index]["number_of_votes"] = temp;
      });
      index++;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Result Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              CustomTextField(
                controller: loginController.selectDate,
                lableText: "Select Date",
                readOnly: true,
                suffixIcon: GestureDetector(
                  onTap: () async {
                    await loginController.calendar(context, true);
                    getData();
                  },
                  child: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Flexible(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.to(ProfileScreen(data: data[index]));
                            },
                            leading: CircleAvatar(
                              radius: 20,
                              child: Text(data[index]["name"][0]),
                            ),
                            title: Text("${data[index]['name']}"),
                            subtitle: Text("${data[index]['political_party']}"),
                            trailing: Text("${data[index]['number_of_votes']}"),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
