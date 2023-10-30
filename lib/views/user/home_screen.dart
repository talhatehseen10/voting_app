import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/views/user/candidate_list_screen.dart';
import 'package:voting/views/user/profile_screen.dart';
import 'package:voting/views/user/voter_list_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Voting System"),
      ),
      drawer: _drawer(context),
      body: Center(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 200.0, enlargeCenterPage: true, autoPlay: true),
              items: ["assets/image5.jpg"].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(i),
                          ),
                          color: Colors.amber),
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
                      const SizedBox(
                          height: 150,
                          width: 150,
                          child: Card(
                            child: Text(
                              "\n \n \t Voting time \n \t 09:30 to 12:30",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          )),
                      SizedBox(
                          height: 150,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const CandidateListScreen());
                            },
                            child: const Card(
                              child: Text(
                                "\n \n \t Candidate List",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 150,
                          width: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VoterListScreen(),
                              ),
                            ),
                            child: Card(
                              child: Text(
                                "\n\nCast your Vote here",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )),
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

  Widget _drawer(BuildContext context) {
    return Drawer(
      elevation: 1,
      shadowColor: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
          ),
          Card(
            elevation: 2,
            child: Column(
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
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            ),
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
