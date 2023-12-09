import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CastVoteScreen extends StatefulWidget {
  const CastVoteScreen({super.key});

  @override
  State<CastVoteScreen> createState() => _CastVoteScreenState();
}

class _CastVoteScreenState extends State<CastVoteScreen> {
  bool isStarted = false;
  bool showLoader = true;
  bool isVoteCasted = false;
  List votes = [];
  List voters = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getStatus() async {
    await FirebaseFirestore.instance.collection("voting").get().then((value) {
      setState(() {
        isStarted = value.docs.first['isStarted'];
        if (isStarted) {
          getVotes();
        }
        showLoader = false;
      });
    });
  }

  Future<void> getVotes() async {
    await FirebaseFirestore.instance
        .collection("votes")
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
        .get()
        .then((value) {
      var data = value.data();

      if (data!["votes"].length == 0) {
      } else if (data["votes"]
          .contains(FirebaseAuth.instance.currentUser!.email)) {
        setState(() {
          isVoteCasted = true;
          voters = data["votes"];
          votes = data["votes_to"];
        });
      }
    });
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: const Text('Candiates List'),
      ),
      body: showLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isStarted && isVoteCasted == false
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("role", isEqualTo: "candidate")
                      .where("isactive", isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Text("Date: "),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    radius: 20,
                                  ),
                                  title: Text(
                                      "${snapshot.data!.docs[index]['name']}"),
                                  subtitle: Text(
                                      "${snapshot.data!.docs[index]['party']}"),
                                  trailing: Checkbox(
                                      value: votes
                                              .contains(auth.currentUser!.email)
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        voters.add(FirebaseAuth
                                            .instance.currentUser!.email!);
                                            votes.add(snapshot.data!.docs[index]['email']);
                                        FirebaseFirestore.instance
                                            .collection("votes")
                                            .doc(DateFormat('dd-MM-yyyy')
                                                .format(DateTime.now()))
                                            .set({
                                          "start_time": "09:00 AM",
                                          "end_time": "05:00 PM",
                                          "votes": voters,
                                          "votes_to": votes,
                                          "isStopped": true,
                                          "date": DateFormat('dd-MM-yyyy')
                                              .format(DateTime.now()),
                                        });
                                        getVotes();
                                      }),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : isVoteCasted
                  ? const Center(
                      child: Text("You have casted your vote"),
                    )
                  : const Center(
                      child: Text("Voting has not been started yet"),
                    ),
    );
  }
}
