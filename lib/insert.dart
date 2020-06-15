import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'convertidor.dart';

class insertar extends StatefulWidget {
  @override
  _Insert createState() => new _Insert();
}

class _Insert extends State<insertar> {
  //Variables referentes al manejo de la bd
  Future<List<Student>> Studentss;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  String name;

  String photoName;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;
  int currentUserId;
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();

  String imagen;
  File _imagen;

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents();
    });
  }

//EL VOID DE GETPHOTOS Y GETSTUDENT

  void cleanData() {
    controller1.text = "";
    controller2.text = "";
    controller3.text = "";
    controller4.text = "";
    controller5.text = "";
    controller6.text = "";
    controller7.text = "";
  }

  void dataValidate() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (isUpdating) {
        Student stu =
            Student(currentUserId, name, surname, ap, mat, mail, num, imagen);
        bdHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, name, surname, ap, mat, mail, num, imagen);
        //VALIDACION MATRICULA
        var validation = await bdHelper.validateInsert(stu);
        print(validation);
        if (validation) {
          bdHelper.insert(stu);
          final snackbar = SnackBar(
            content: new Text("DATOS INGRESADOS!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        } else {
          final snackbar = SnackBar(
            content: new Text("LA MATRICULA YA FUE REGISTRADA!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        }
      }
      cleanData();
      refreshList();
    }
  }

  pickImagefromGallery(BuildContext context) {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      // Photo photo = Photo(null,imgString);
      //bdHelper.insert(photo);
      //fotos();
      imagen = imgString;
      Navigator.of(context).pop();
      controller7.text = "Campo lleno";
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
      controller7.text = "Campo lleno";
      return imagen;
    });
  }

  // seleccionar imagen
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
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Insertar Datos "),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                /* Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.grey,
                  child: imagen == null ? Text("Inserta una imagen",textAlign: TextAlign.center):
                  (Convertir.imageFromBase64sString(imagen))
                  ),*/
                /*CircleAvatar(
                  radius: 88,
                  backgroundImage: Image.memory(Convertir.imageFromBase64sString(imagen)),
                ),*/
                TextFormField(
                  controller: controller7,
                  decoration: InputDecoration(
                      labelText: "Photo",
                      suffixIcon: RaisedButton(
                        color: Colors.deepPurple[200],
                          onPressed: () {
                            _selectfoto(context);
                          },
                          child: Text("Select image", textAlign: TextAlign.center,),
                      )),
                  validator: (val) => val.length == 0
                      ? 'Debes subir una imagen'
                      : controller7.text == "Campo lleno"
                          ? null
                          : "Solo imagenes",
                ),
                TextFormField(
                  controller: controller1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Student Name"),
                  validator: (val) => val.length == 0 ? 'Enter name' : null,
                  onSaved: (val) => name = val,
                ),
                TextFormField(
                  controller: controller2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Paternal Surname"),
                  validator: (val) =>
                      val.length == 0 ? 'Enter paternal surname' : null,
                  onSaved: (val) => surname = val,
                ),
                TextFormField(
                  controller: controller5,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Maternal Surname"),
                  validator: (val) =>
                      val.length == 0 ? 'Enter maternal surname' : null,
                  onSaved: (val) => ap = val,
                ),
                TextFormField(
                  controller: controller6,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Student ID"),
                  validator: (val) =>
                      val.length < 10 ? 'Enter student id' : null,
                  onSaved: (val) => mat = val,
                ),
                TextFormField(
                  controller: controller3,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Student Mail"),
                  validator: (val) => !val.contains('@') ? 'Enter mail' : null,
                  onSaved: (val) => mail = val,
                ),
                TextFormField(
                  controller: controller4,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Student phone"),
                  validator: (val) =>
                      val.length < 10 ? 'Enter phone number' : null,
                  onSaved: (val) => num = val,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.deepPurple)),
                      onPressed: dataValidate,
                      child: Text(isUpdating ? 'Update' : 'Add Data'),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.deepPurple)),
                      onPressed: () {
                        setState(() {
                          isUpdating = false;
                        });
                        cleanData();
                      },
                      child: Text('Cancel'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      /*floatingActionButton: SpeedDial(
        backgroundColor: Colors.deepPurpleAccent[100],
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            label: "Tomar Foto",
            labelBackgroundColor: Colors.black,
            backgroundColor: Colors.deepPurpleAccent,
            onTap: () {
              pickImagefromCamera(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.photo),
            label: "Subir Imagen",
            labelBackgroundColor: Colors.black,
            backgroundColor: Colors.deepPurple,
            onTap: () {
              pickImagefromGallery();
            },
          )
        ],
      ),*/
    );
  }
}
