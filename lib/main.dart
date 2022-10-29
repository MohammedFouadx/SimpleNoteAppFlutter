import 'package:flutter/material.dart';
import 'package:note_taking_app/views/screens/add_note_screen.dart';
import 'package:note_taking_app/views/screens/home_screen.dart';


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) =>  const HomeScreen(),
        "/AddNote" : (context) => const AddNoteScreen()
      },
    );
  }
}
