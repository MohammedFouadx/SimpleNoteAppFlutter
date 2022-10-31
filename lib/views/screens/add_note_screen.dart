

import 'package:flutter/material.dart';
import 'package:note_taking_app/db/database_provider.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/utils/color.dart';
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  addNote(NoteModel note)async{
    await DatabaseProvider.db.addNewNote(note);
    print("new note added successfully");
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var currentTime =  DateTime(now.year, now.month, now.day);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Note"),
          centerTitle: true,
          backgroundColor: mainColor,
        ),
      body: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12 , left: 12 , right: 12),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,

                ),
                validator: (value){
                  if(value!.isEmpty) {
                    return "Please enter a title";
                  }
                },
                style: TextStyle(
                  fontSize: 28,
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: greyColor.withOpacity(0.1)
                ),
                child: TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Note Details ... ",
                    border: InputBorder.none,
                  ),
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Please enter a brief detail for your note";
                    }
                  },

                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(25)
        ),
        child: FloatingActionButton.extended(
          onPressed: (){
            if(_key.currentState!.validate()){
              NoteModel note = NoteModel(
                title: titleController.text.toUpperCase(),
                body: descController.text,
                creationDate: currentTime,
              );
              addNote(note);
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            }



          },
          label: const Text(
            "Save Note",
            style: TextStyle(
              color: mainColor
            ),
          ),
          backgroundColor: whiteColor,
          extendedIconLabelSpacing: 5.0,

        ),
      ),
    );
  }
}
