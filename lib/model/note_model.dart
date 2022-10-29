
class NoteModel {
  int? id;
  String? title;
  String? body;
  DateTime? creationDate;


  NoteModel({this.id , this.title , this.body , this.creationDate});


  Map<String , dynamic> toMap(){
    return ({
      "id" : id,
      "title" : title,
      "body" : body,
      "creation_date" : creationDate.toString()
    });
  }



}