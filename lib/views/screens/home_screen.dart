import 'package:flutter/material.dart';
import 'package:note_taking_app/db/database_provider.dart';
import 'package:note_taking_app/model/note_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes () async{
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  deleteNote (int id) async{
    final notes = await DatabaseProvider.db.deleteNote(id);
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    var list;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const  Text("Note app"),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: getNotes(),
        builder: (context , snapshot){
          if(snapshot.hasData){
             list = snapshot.data!;
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
            child: CircularProgressIndicator(color: Colors.teal,),
          )
              : snapshot.connectionState == ConnectionState.done
              ? list == null
              ? const Center(
                child: Text("You do not have any notes yet, create one"))
              : ListView.builder(
                  itemCount: list.length ,
                  itemBuilder: (context , index){
                    return Material(
                      elevation: 0.2,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          list[index]['title'],
                          style: const  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        subtitle: Text(
                          list[index]['body'],
                          style: const  TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        trailing: Text(
                          list[index]['creation_date'],
                          style: const  TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                        ),
                        leading: InkWell(
                          onTap: (){
                            setState(() {
                              deleteNote(list[index]["id"]);
                            });

                            print("deleted");
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
          )
              : const Center(
                  child: Text("Ops!"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/AddNote");
        },
        backgroundColor: Colors.white,
        child: const  Icon(Icons.add , color: Colors.teal,),
      ),
    );
  }
}
