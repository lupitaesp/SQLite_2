import 'crud_operations.dart';
import 'students.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<Select> {
  //Variable referentes al manejo de la BD
  Future<List<Student>> Studentss;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  String name;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;

  String valor;
  int currentUserId;
  int opcion;

  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;


  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  //select
  void refreshList() {
    setState(() {
      Studentss = dbHelper.select(searchController.text);
    });
  }





  void cleanData() {
    // Lo que vamos a utilizar
    searchController.text = "";
  }

//Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Matricula"),
          ),
          DataColumn(
            label: Text("Nombre"),
          ),
          DataColumn(
            label: Text("A. Paterno"),
          ),
          DataColumn(
            label: Text("A. Materno"),
          ),

          DataColumn(
            label: Text("E-mail"),
          ),
          DataColumn(
            label: Text("Telefono"),
          ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [

          //NOMBRE 1
          DataCell(Text(student.mat.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controller6.text = student.mat;
          }),
          DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controller1.text = student.name;
          }),
          //APELLIDO PATERNO 2
          DataCell(Text(student.surname.toString().toUpperCase()),
              onTap: () {
                setState(() {
                  isUpdating = true;
                  currentUserId = student.controlum;
                });
                controller2.text = student.surname;
              }),
          //APELLIDO MATERNO 3
          DataCell(Text(student.ap.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controller5.text = student.ap;
          }),
          //TELEFONO 4

          DataCell(Text(student.mail.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controller3.text = student.mail;
          }),
          DataCell(Text(student.num.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controller4.text = student.num;
          }),
        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No data founded!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: isUpdating ? TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (text){
              refreshList();
            })
            : Text("Buscando por matricula"),
        leading: IconButton(
          icon: Icon(isUpdating ? Icons.done: Icons.search,),
          onPressed: (){
            print("Is typing"+ isUpdating.toString());
            setState(() {
              isUpdating = !isUpdating;
              searchController.text = "";
            });
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}
