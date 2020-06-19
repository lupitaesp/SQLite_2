import 'students.dart';
import 'package:flutter/material.dart';
import 'convertidor.dart';
import 'package:image_picker/image_picker.dart';
class DetailPage extends StatelessWidget{

  final Student student;
  DetailPage(this.student);

  String imagen;

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
      Navigator.of(context).pop();
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(student.name.toString().toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
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
                    color: Colors.transparent,
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
                              backgroundColor: Colors.white,
                              backgroundImage: Convertir.imageFromBase64sString(student.photoName).image,
                    
                        ),
                        new RaisedButton( color: Colors.deepPurple[200],
                          onPressed: () {
                            _selectfoto(context);
                          },
                          child: Text("Update image", textAlign: TextAlign.center,),),
                        new Padding(padding: EdgeInsets.all(10.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        //NOMBRE
                        Text(
                          student.name.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 25.0,
                              //fontWeight: FontWeight.bold
                          ),
                        ),
                        //APELLIDO PATERNO
                        Text(
                          student.surname.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 25.0,
                              //fontWeight: FontWeight.bold
                          ),
                        ),
                        //APELLIDO MATERNO
                        Text(
                          student.ap.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 25.0,
                              //fontWeight: FontWeight.bold
                          ),
                        ),
                          ],
                        ),
                        //MATRICULA
                        new Padding(padding: EdgeInsets.all(10.0),),
                        Text("Matricula: ${student.mat}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black45
                          ),
                        ),
                        //EMAIL
                        new Padding(padding: EdgeInsets.all(15.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Email: ${student.mail}",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                      ],
                    ),
                    new Padding(padding: EdgeInsets.all(10.0),),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Telefono: ${student.num}",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                        ],
                      ),
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