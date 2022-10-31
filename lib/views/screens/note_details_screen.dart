

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/db/database_provider.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/utils/color.dart';
import 'package:note_taking_app/views/screens/home_screen.dart';
class NoteDetailsScreen extends StatefulWidget {

  final String title;
  final String body;
  final int id;

  const NoteDetailsScreen({Key? key ,
    required this.title ,
    required this.body,
    required this.id
  }) : super(key: key);

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {

  TextEditingController newTitleController = TextEditingController();
  TextEditingController newBodyController = TextEditingController();
  update (String title , String body , int id) async{
    final notes = await DatabaseProvider.db.updateNote(title , body , id);
    return notes;
  }

  @override
  void initState() {
    newTitleController.text = widget.title;
    newBodyController.text = widget.body;
    super.initState();
  }

  @override
  void dispose() {
   newTitleController.dispose();
   newBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const  Text("Note Details"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12 , left: 12 , right: 12),
            child: TextFormField(
              controller: newTitleController,
              decoration: const InputDecoration(
                hintText: "Title",

                border: InputBorder.none,

              ),
              validator: (value){
                if(value!.isEmpty) {
                  return "Please enter a title";
                }
              },
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12 , right: 12),
            child: Divider(
              color: greyColor,
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: greyColor.withOpacity(0.1)
            ),
            child: TextFormField(
              controller: newBodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "",
                border: InputBorder.none,
              ),
              validator: (value){
                if(value!.isEmpty) {
                  return "Please enter a brief detail for your note";
                }
              },

            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          update(newTitleController.text.toUpperCase(),  newBodyController.text , widget.id);
          Get.offAll( const HomeScreen());
        },
        backgroundColor: blueColor,

        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(FontAwesomeIcons.arrowsRotate , size: 15, color: whiteColor,),
            SizedBox(width: 5,),
            Text(
                "update"
            ),


          ],
        ),
      ),
    );
  }
}
