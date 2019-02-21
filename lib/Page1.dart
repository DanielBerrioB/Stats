import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ExpansionList.dart';
import 'package:flare_flutter/flare_actor.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page1();
}

class _Page1 extends State<Page1> {
  int stateKey = 0;
  static List<Usuario> users = new List();
  String mainTitle = "Página principal";

  Widget pageDirection(stateKey, BuildContext context) {
    if (stateKey == 1) {
      //This class allows you to use the data from firebase
      return FirebaseAnimatedList(
          query: FirebaseDatabase.instance.reference().child("usuarios"),
          itemBuilder: (context, snapshot, animation, index) {
            return new Column(children: <Widget>[
              new ListTile(
                title: Text(snapshot.value['nombre'].toString()),
                onTap: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Resultados"),
                            content: Text(
                              "Nombre: " +
                                  snapshot.value['nombre'] +
                                  "\nCorreo: " +
                                  snapshot.value['email'].toString() +
                                  "\nFecha: " +
                                  snapshot.value['fecha'].toString() +
                                  "\nPuntaje: " +
                                  snapshot.value['puntaje'].toString(),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Aceptar"),
                                onPressed: () =>
                                    Navigator.pop(context, "Aceptar"),
                              ),
                            ],
                          ));
                },
              ),
            ]);
          });
    } else {
      return new Stack(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(
              top: 70.0,
              left: 50.0,
              right: 20.0,
            ),
            child: Text(
              "Bienvenido",
              style: const TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Jorge Bedoya"),
      accountEmail: Text("Análisis geométrico"),
      currentAccountPicture: CircleAvatar(
        child: Text(
          "J",
          style: const TextStyle(
              fontSize: 35.0, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text("Página principal"),
          onTap: () {
            setState(() {
              mainTitle = "Página principal";
              stateKey = 0;
            });
          },
        ),
        ListTile(
          title: Text("Estudiantes"),
          onTap: () {
            setState(() {
              mainTitle = "Estudiantes";
              stateKey = 1;
            });
          },
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(mainTitle),
        elevation: 1.0,
      ),
      body: pageDirection(stateKey, context),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
