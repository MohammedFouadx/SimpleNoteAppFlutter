import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/utils/theme.dart';
import 'package:note_taking_app/views/screens/add_note_screen.dart';
import 'package:note_taking_app/views/screens/home_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await dep.init();
  runApp(MyApp(),);
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeAppLight(),
      darkTheme: themeAppDark(),
      home: const HomeScreen(),
      // initialRoute: "/",
      // routes: {
      //   "/" : (context) =>  const HomeScreen(),
      //   "/AddNote" : (context) => const AddNoteScreen()
      // },
    );
  }
}
