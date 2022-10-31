import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:note_taking_app/db/database_provider.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/utils/color.dart';
import 'package:note_taking_app/utils/theme.dart';
import 'package:note_taking_app/views/screens/add_note_screen.dart';
import 'package:note_taking_app/views/screens/note_details_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {


  List notesList = [];
  getNotes () async{
    final notes = await DatabaseProvider.db.getNotes();
    notesList.addAll(notes);
    if(this.mounted){
      setState(() {

      });
    }
    // return notes;
    print(notes);
    print(notesList);
  }

  deleteNote (int id) async{
    final notes = await DatabaseProvider.db.deleteNote(id);

    return notes;
  }




  @override
  void initState() {
   getNotes();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);
    // var list;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: const  Text("Note app"),
        centerTitle: true,


      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        color: whiteColor,
        child: ListView.builder(
          itemCount: notesList.length,
          // separatorBuilder: (context , _) => const SizedBox(height: 5,),
          itemBuilder: (context , index){
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: (){
                  Get.to(NoteDetailsScreen(
                    title: notesList[index]['title'],
                    body: notesList[index]['body'],
                    id: notesList[index]['id'],
                  ));
                },
                child: ClayContainer(
                  color: baseColor,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notesList[index]['title'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: blueColor
                              ),
                            ),
                            const SizedBox(height: 3,),
                            Text(
                              notesList[index]['body'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: blueColor
                              ),
                            ),
                            const SizedBox(height: 3,),
                            Text(
                              notesList[index]['creation_date'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: blueColor
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: ClayContainer(
                          color: baseColor,
                          height: 40,
                          width: 40,
                          customBorderRadius: const BorderRadius.only(
                              bottomLeft: Radius.elliptical(150, 150),
                              topLeft: Radius.circular(50)),
                          child: InkWell(
                            onTap: (){

                              Get.defaultDialog(
                                  title: "Delete !",
                                  middleText: "${notesList[index]['title']}",
                                  backgroundColor: whiteColor,
                                  titleStyle: TextStyle(color: blueColor),
                                  middleTextStyle: TextStyle(color: blueColor),
                                  radius: 30,
                                  textConfirm: "Yes",
                                  textCancel: "No",
                                  confirmTextColor: whiteColor,
                                  onConfirm: (){
                                    setState(() {
                                      deleteNote(notesList[index]['id']);
                                      notesList.removeWhere((element) =>
                                      element["id"] == notesList[index]['id']
                                      );
                                      Get.back();
                                    });
                                  }
                              );


                            },
                            child: Icon(
                              FontAwesomeIcons.trash,
                              size: 15,
                              color: redColor,
                            ),
                          ),
                        ),

                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClayContainer(
                          color: baseColor,
                          height: 40,
                          width: 40,
                          customBorderRadius: const BorderRadius.only(
                              bottomLeft: Radius.elliptical(150, 150),
                              topLeft: Radius.circular(50)),
                          child: const Icon(
                            FontAwesomeIcons.edit,
                            size: 15,
                            color: Colors.green,
                          ),
                        ),

                      ),

                    ],
                  ),
                ),
              ),
            );

          },
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         Get.to( const AddNoteScreen());
        },
        backgroundColor: blueColor,

        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(FontAwesomeIcons.plus , size: 15, color: whiteColor,),
             SizedBox(width: 5,),
             Text(
                "Add Note"
            ),


          ],
        ),
      ),
    );
  }
}
