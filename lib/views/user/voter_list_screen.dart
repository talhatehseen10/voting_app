import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoterListScreen extends StatelessWidget {
  const VoterListScreen({super.key});

  final bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        title: const Text('Voters List'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("role", isEqualTo: "candidate")
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                  ),
                  title: Text("Arshad Ali"),
                  subtitle: Text("Pakistan Zindabad"),
                  trailing: Checkbox(
                      value: isChecked,
                      onChanged: (val) {
                        setState() {}
                        ;
                      }),
                );
              },
            );
          }),
    );
  }
}
