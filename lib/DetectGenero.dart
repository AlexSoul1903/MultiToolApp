import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetectGenero extends StatefulWidget {
  @override
  _DetectGeneroState createState() => _DetectGeneroState();
}

class _DetectGeneroState extends State<DetectGenero> {
  String nom = '';
  String genero = '';
  Color colorFondo = Colors.white;
  Future<void> obtenerGenero(String nom) async {
    var url = Uri.parse('https://api.genderize.io/?name=$nom');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var generos = jsonDecode(response.body);
      setState(() {
        genero = generos['gender'];
        colorFondo = (genero == 'female') ? Colors.pinkAccent : Colors.blue;
      });
    }

    if (genero == 'female') {
      genero = 'Femenino';
    } else {
      genero = 'Masculino';
    }
  }

  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Alineación vertical centrada
      children: [
        Text(
          'Ingresa el nombre de una persona para predecir su género:',
          style: TextStyle(
            color: textColor,
            fontFamily: 'Georgia',
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Container(
          width: 250,
          child: TextField(
            onChanged: (value) {
              setState(() {
                nom = value;
              });
            },
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              labelText: 'Ingrese un nombre',
              fillColor: Color.fromARGB(255, 213, 252, 223),
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            obtenerGenero(nom);
          },
          child: Text('Comprobar.'),
        ),
        SizedBox(height: 20),
        Text(
          'Género detectado: $genero',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 200,
          height: 200,
          color: colorFondo,
        ),
      ],
    );
  }
}
