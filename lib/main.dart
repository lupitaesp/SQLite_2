import 'package:base/convertidor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:async';
import 'insert.dart';
import 'delete.dart';
import 'update.dart';
import 'select.dart';
import 'busqueda.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData(brightness: Brightness.light, primarySwatch: Colors.cyan),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.blueGrey),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
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
  List<Student> imagenes;

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




  void cleanData() {
    controller1.text = "";
    controller2.text = "";
    controller3.text = "";
    controller4.text = "";
    controller5.text = "";
    controller6.text = "";
  }

  //Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Control"),
          ),
          DataColumn(
            label: Text("Studen ID"),
          ),
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Paternal Surname"),
          ),
          DataColumn(
            label: Text("Maternal Surname"),
          ),

          DataColumn(
            label: Text("E-mail"),
          ),
          DataColumn(
            label: Text("Phone"),
          ),
          //DataColumn(
            //label: Text("Photo"),
       //   ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [
          DataCell(Text(student.controlum.toString())),
          DataCell(Text(student.mat.toString().toUpperCase())),
          DataCell(Text(student.name.toString().toUpperCase())),
          //CONVIERTE LETRAS
          DataCell(Text(student.surname.toString().toUpperCase())),
          DataCell(Text(student.ap.toString().toUpperCase())),
          DataCell(Text(student.mail.toString().toUpperCase())),
          DataCell(Text(student.num.toString().toUpperCase())),
         //Muestra la imagen
         //DataCell(Convertir.imageFromBase64sString(student.photoName)),
        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("Not data founded");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  final formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                child: Text(
                  "MENU",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              leading: Icon(Icons.system_update_alt, color: Colors.deepPurpleAccent),
              title: Text('ACTUALIZAR TABLA'),
              onTap: refreshList,
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.deepPurpleAccent),
              title: Text('INSERTAR DATOS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => insertar()));
              },
            ),
           ListTile(
              leading: Icon(Icons.update, color: Colors.deepPurpleAccent),
              title: Text('ACTUALIZAR DATOS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Update()));
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.deepPurpleAccent),
              title: Text('BUSCAR DATOS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Select()));
              },
            ),
            ListTile(
              leading: Icon(Icons.refresh, color: Colors.deepPurpleAccent),
              title: Text('CONSULTAR REGISTROS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => busqueda()));
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.deepPurpleAccent),
              title: Text('ELIMINAR DATOS'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => eliminar()));
              },
            ),
          ],
        ),
      ),
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Basic SQL operations"),
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

  _snack(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: new Text(texto),
      backgroundColor: Colors.deepPurple,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
