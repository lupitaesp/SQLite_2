import 'students.dart';
import 'package:flutter/material.dart';
import 'convertidor.dart';
import 'package:image_picker/image_picker.dart';
import 'students.dart';
import 'crud_operations.dart';

class DetailPage extends StatelessWidget{

  final Student student;
  DetailPage(this.student);
  int opcion;
  final formkey = new GlobalKey<FormState>();
  String photoName;
  int currentUserId;
  var bdHelper;
  String imagen;

    String name;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;
  String valor;

/*
void updateData(){
    print("Valor de Opción");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      //NOMBRE
      if (opcion==1) {
        Student stu = Student(currentUserId,valor, surname, ap, mat, mail, num, photoName);
        bdHelper.update(stu);
      }
      //APELLIDO PATERNO
      else if (opcion==2) {
        Student stu = Student(currentUserId,name, valor, ap, mat, mail, num, photoName);
        bdHelper.update(stu);
      }
      cleanData();
      refreshList();
    }
  }
*/
/*
//Metodo para imagen
  pickImagefromGallery(BuildContext context) {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      // Photo photo = Photo(null,imgString);
      //bdHelper.insert(photo);
      //fotos();
      imagen = imgString;
      //Funciona para la obtencion de imagen ya sea galeria o camera
      Navigator.of(context).pop();
      return imagen;
    });
  }


  pickImagefromCamera(BuildContext context) {
    ImagePicker.pickImage(source: ImageSource.camera).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      // Photo photo = Photo(null,imgString);
      //bdHelper.insert(photo);
      //fotos();
      imagen = imgString;

    //  Navigator.of(context).pop(bdHelper.update(stu));
      return imagen;
    });
  }

 // seleccionar imagen ya se camara o galeria
  Future<void> _selectfoto(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choise!", textAlign: TextAlign.center,),
              backgroundColor: Colors.deepPurpleAccent[200],
              content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  pickImagefromGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              GestureDetector(
                child: Text("Camera",),
                onTap: () {
                  pickImagefromCamera(context );
                },
              )
            ]),
          ));
        });
  }
  */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
          title: Text(student.name.toString().toUpperCase()+" "+student.surname.toString().toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 19,
              left: 10.0,
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.10,
              child: Container(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        //FOTOGRAFIA
                        CircleAvatar(
                          minRadius: 80.0,
                              maxRadius:  80.0,
                              backgroundColor: Colors.black,
                              backgroundImage: Convertir.imageFromBase64sString(student.photoName).image,
                           
                              
                        ),
                       /* new RaisedButton( color: Colors.deepPurple[200],
                          onPressed: () {
                            _selectfoto(context);
                          },
                          child: Text("Update image", textAlign: TextAlign.center,),),*/
                        new Padding(padding: EdgeInsets.all(10.0),),
              
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        //NOMBRE
                        Text(
                          student.name.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        //APELLIDO PATERNO
                          ],
                        ),
                        new Padding(padding: EdgeInsets.all(6.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        //NOMBRE
                        Text(
                          student.surname.toString().toUpperCase()
                          +" "+ student.ap.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0,
                               color: Colors.black,
                             // fontWeight: FontWeight.bold
                          ),
                        ),
                        //APELLIDO PATERNO
                          ],
                        ),
                        Divider(
                          color: Colors.deepPurpleAccent,
                           indent: 20,
                              endIndent: 20,
                              thickness: 3.0
                        ),

                        //MATRICULA
                        new Padding(padding: EdgeInsets.all(10.0),
                        ),
                      RaisedButton.icon(
                        onPressed: (){ print('Button Clicked.'); },
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        label: Text("Matricula: "+ "     "+ "${student.mat}", 
                              style: TextStyle(color: Colors.white),),
                        icon: Icon(Icons.info, color:Colors.white,), 
                        color: Colors.deepPurple[300],),
                                            
                        //EMAIL
                        new Padding(padding: EdgeInsets.all(10.0),),
                        RaisedButton.icon(
                        onPressed: (){ print('Button Clicked.'); },
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        label: Text("Email: "+ "     "+ "${student.mail}", 
                              style: TextStyle(color: Colors.white),),
                        icon: Icon(Icons.mail, color:Colors.white,), 
                        color: Colors.deepPurple[400],),
                    new Padding(padding: EdgeInsets.all(10.0),),
                   RaisedButton.icon(
                        onPressed: (){ print('Button Clicked.'); },
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        label: Text("Telefono: "+ "     "+ "${student.num}", 
                              style: TextStyle(color: Colors.white),),
                        icon: Icon(Icons.phone, color:Colors.white,), 
                        color: Colors.deepPurple[500],),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ],
        )
    );
  }
}