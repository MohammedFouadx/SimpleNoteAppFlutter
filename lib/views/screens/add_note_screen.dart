

import 'package:flutter/material.dart';
import 'package:note_taking_app/db/database_provider.dart';
import 'package:note_taking_app/model/note_model.dart';
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
          backgroundColor: Colors.teal,
        ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,

              ),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: descController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "your note",
                border: InputBorder.none,
              ),

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          NoteModel note = NoteModel(
            title: titleController.text.toUpperCase(),
            body: descController.text,
            creationDate: currentTime,
          );
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);

        },
        label: const Text(
          "Save Note"
        ),
        backgroundColor: Colors.teal,

      ),
    );
  }
}
