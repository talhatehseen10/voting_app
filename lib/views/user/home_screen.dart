import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/views/user/candidate_list_screen.dart';
import 'package:voting/views/user/cast_vote_screen.dart';
import 'package:voting/views/user/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Voting System"),
      ),
      drawer: _drawer(context, loginController),
      body: Center(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 200.0, enlargeCenterPage: true, autoPlay: true),
              items: [
                "assets/1.jpg",
                "assets/2.jpg",
                "assets/3.jpg",
                "assets/4.jpg",
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(i),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Card(
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "\n \n \t Voting time \n09:00 to 05:00 PM",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Get.to(CandidateListScreen());
                        },
                        child: Card(
                          child: Container(
                            height: 150,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                "Candidate List",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(CastVoteScreen());
                          },
                          child: Card(
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cast Voter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context, LoginController controller) {
    return Drawer(
      elevation: 1,
      shadowColor: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.08,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(loginController.userData!['name']),
              const SizedBox(
                height: 4,
              ),
              Text(loginController.userData!['email']),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Get.to(ProfileScreen(
                data: controller.userData!,
              ));
            },
            title: const Text("Profile"),
            trailing: const Icon(Icons.person_rounded),
          ),
          ListTile(
            onTap: () {
              loginController.userSignOut();
            },
            title: const Text("Log out"),
            trailing: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}
