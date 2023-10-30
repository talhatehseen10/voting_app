import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        centerTitle: true,
        title: const Text("Online Voting System"),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 80,
            ),
            Text(
              "Akhtar aaali",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Text("Mobile no",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              trailing: Text(
                "12345678910",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Address",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                "TandoJam",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Date Of Birth",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                "01/01/1999",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "CNIC",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                "11111-1111111-1",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Status",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                "Voted or Not Voted",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
