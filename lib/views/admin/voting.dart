import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voting/views/admin/create_voting.dart';

// ignore: must_be_immutable
class Voting extends StatelessWidget {
  Voting({super.key});
  final format = DateFormat('yyyy-MM-dd – kk:mm');
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, String id, String start,
      String end, bool isStarted, bool isStart) async {
    TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTime && isStart) {
      await FirebaseFirestore.instance.collection("voting").doc(id).set({
        "isStarted": isStart,
        "start_time": picked_s,
        "end_time": end,
      });
    } else if (picked_s != null &&
        picked_s != selectedTime &&
        isStart == false) {
      await FirebaseFirestore.instance.collection("voting").doc(id).set({
        "isStarted": isStart,
        "start_time": start,
        "end_time": picked_s,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Voting Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateVoting());
        },
        child: const Center(
          child: Icon(
            Icons.poll,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("voting").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectTime(
                                context,
                                snapshot.data!.docs.first.id,
                                snapshot.data!.docs.first['start_time'],
                                snapshot.data!.docs.first['end_time'],
                                snapshot.data!.docs.first['isStarted'],
                                true);
                          },
                          child: Text(snapshot.data!.docs.first["start_time"]),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectTime(
                                context,
                                snapshot.data!.docs.first.id,
                                snapshot.data!.docs.first['start_time'],
                                snapshot.data!.docs.first['end_time'],
                                snapshot.data!.docs.first['isStarted'],
                                false);
                          },
                          child: Text(snapshot.data!.docs.first["end_time"]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    snapshot.data!.docs.first['isStarted']
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("voting")
                                  .doc(snapshot.data!.docs.first.id)
                                  .set({
                                "isStarted": false,
                                "start_time":
                                    snapshot.data!.docs.first["start_time"],
                                "end_time":
                                    snapshot.data!.docs.first["end_time"],
                              });
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 150,
                              child: Center(
                                child: Text(
                                  "End Voting",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade400,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("voting")
                                  .doc(snapshot.data!.docs.first.id)
                                  .set({
                                "isStarted": true,
                                "start_time":
                                    snapshot.data!.docs.first["start_time"],
                                "end_time":
                                    snapshot.data!.docs.first["end_time"],
                              });
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 150,
                              child: Center(
                                child: Text(
                                  "Start Voting",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
