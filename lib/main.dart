import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instareels/Home.dart';
import 'package:workmanager/workmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



const fetchBackground = "fetchBackground";



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Workmanager().initialize(
    callbackDispatcher,
  );
  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(Home());
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
      // Code to run in background
       Firebase.initializeApp();
        print("hello hemant backgroud is going on");
        FirebaseFirestore.instance.collection('userinfo').add({'username:':" This is hemant workmanager"} );

        break;
    }
    return Future.value(true);
  });
}