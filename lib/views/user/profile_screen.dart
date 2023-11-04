import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 80,
              child: Text(
                data["name"][0],
                style: const TextStyle(fontSize: 40),
              ),
            ),
            Text(
              data["name"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              child: data["role"] == "admin"
                  ? const SizedBox()
                  : Column(
                      children: [
                        ListTile(
                          leading: const Text("Mobile no",
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          trailing: Text(
                            data["mobileno"],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Text(
                            "Address",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          trailing: Text(
                            data["address"],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Text(
                            "Date Of Birth",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            data["dob"],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Text(
                            "CNIC",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            data["cnic"],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // ListTile(
                        //   leading: const Text(
                        //     "Status",
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        //   trailing: Text(
                        //     "Voted or Not Voted",
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
