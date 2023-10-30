import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CandidateListScreen extends StatelessWidget {
  const CandidateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  leading: const CircleAvatar(
                    radius: 20,
                  ),
                  title: Text("${snapshot.data!.docs[index]['name']}"),
                  subtitle: Text("${snapshot.data!.docs[index]['party']}"),
                  trailing: const CircleAvatar(
                    radius: 20,
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
