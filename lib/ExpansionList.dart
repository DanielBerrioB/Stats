import 'package:data_visualization/ExpansionList.dart';
import 'package:data_visualization/ExpansionList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EntryList{
  final notesReference = FirebaseDatabase.instance.reference().child('usuarios');
  List<Usuario> users = new List();

  EntryList(){
    notesReference.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
      users.add(new Usuario.fromSnapshot(event.snapshot));
  }

  String returnList(){
    //const List<Entry> data;
    String hola = "";
    for(int i = 0;i<users.length;i++){
      hola += users.elementAt(i).correo.toString();
    }
    return hola;
  }
}

class Entry{
  const Entry(this.title, [this.children = const<Entry>[]]);
  final String title;
  final List<Entry> children;
}

class Usuario{
  String nombre;
  String correo;
  String fecha;
  double puntaje;

  Usuario(String nombre, String correo, String fecha, double puntaje ){
    this.nombre = nombre;
    this.correo = correo;
    this.fecha = fecha;
    this.puntaje = puntaje;
  }

  Usuario.fromSnapshot(DataSnapshot snapshot)
      : nombre = "Cualquier",
        correo = snapshot.value("email"),
        fecha = snapshot.value("fecha"),
        puntaje = snapshot.value("puntaje");

  getNombre() {
    return nombre;
  }

  getCorreo() {
    return correo;
  }

  getFecha() {
    return fecha;
  }

  getPuntaje(){
    return puntaje;
  }
}

