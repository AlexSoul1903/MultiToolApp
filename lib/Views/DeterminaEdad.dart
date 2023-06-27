import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multitoolapp/NavBar.dart';

class DeterminaEdad extends StatefulWidget {
  @override
  _DeterminaEdadState createState() => _DeterminaEdadState();
}

class _DeterminaEdadState extends State<DeterminaEdad> {
  int edad = 0;
  String nombre = '';
  String mensaje = '';
  String imagen = 'assets/imgs/Edad.png';

  Future<void> obtenerMensajeEdad(String nombre) async {
    var url = Uri.parse('https://api.agify.io/?name=$nombre');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var mensajeEdad = jsonDecode(response.body);
      setState(() {
        mensaje = obtenerMsgEstado(mensajeEdad['age']);
        edad = mensajeEdad['age'];
        imagen = obtenerImagenEstado(edad);
      });
    }
  }

  String obtenerImagenEstado(int edad) {
    if (edad < 18) {
      return 'assets/imgs/Joven.png';
    } else if (edad >= 18 && edad < 60) {
      return 'assets/imgs/Adulto.png';
    } else {
      return 'assets/imgs/Viejo.png';
    }
  }

  String obtenerMsgEstado(int edad) {
    if (edad < 18) {
      return 'Joven';
    } else if (edad >= 18 && edad < 60) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  String fontType = 'Georgia';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          'Determina Edad',
          style: TextStyle(
            fontFamily: 'Georgia',
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(234, 249, 248, 248),
      ),
      backgroundColor: Color.fromARGB(255, 8, 103, 116),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nombre: $nombre',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: fontType,
              ),
            ),
            Text(
              'Edad: $edad',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: fontType,
              ),
            ),
            Text(
              'Mensaje: $mensaje',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: fontType,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              imagen,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Ingrese un Nombre:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                obtenerMensajeEdad(nombre);
              },
              child: Text('Determinar Edad'),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
