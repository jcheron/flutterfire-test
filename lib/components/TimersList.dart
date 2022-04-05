import 'dart:developer';

import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:firebasetest/models/Timer.dart';
import 'package:flutter/material.dart';

class TimersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder<TimerQuerySnapshot>(
        ref: timersRef,
        builder: (context, AsyncSnapshot<TimerQuerySnapshot> snapshot, Widget? child) {
          if (snapshot.hasError) {
          log(snapshot.error.toString());
            return Text('Something went wrong!');
          }
          if (!snapshot.hasData) return Text('Loading timers...');

          // Access the QuerySnapshot
          TimerQuerySnapshot querySnapshot = snapshot.requireData;

          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),

            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              // Access the User instance
              Timer timer = querySnapshot.docs[index].data;

              return Card(child:ListTile(title:Text('Timer name: ${timer.name}')));
            },
          );
        }
    );
  }
}