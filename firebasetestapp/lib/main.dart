import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetestapp/firebase_options.dart';
import 'package:firebasetestapp/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await testData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      testData();

      return MaterialApp(
          title: 'Events',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: const EventScreen(),
      );

  }
   
}


Future<void> testData() async {

  final db = FirebaseFirestore.instance;

  final QuerySnapshot<Map<String,dynamic>> snapshot = 
    await db.collection('event_details').get();

  final List<QueryDocumentSnapshot<Map<String,dynamic>>> details = snapshot.docs;

  for (final doc in details){
    print('Document ID: ${doc.id}');
    print('Document Data: ${doc.data()}');

  }


}