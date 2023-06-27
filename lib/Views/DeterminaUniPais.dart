import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:multitoolapp/NavBar.dart';
import 'package:multitoolapp/util/AbrirWeb.dart';

class DeterminaUniPais extends StatefulWidget {
  @override
  _DeterminaUniPaisState createState() => _DeterminaUniPaisState();
}

class _DeterminaUniPaisState extends State<DeterminaUniPais> {
  String pais = '';
  List<dynamic> unis = [];

  Future<void> obtenerUnis(String pais) async {
    var url =
        Uri.parse('http://universities.hipolabs.com/search?country=$pais');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        unis = data;
      });
    } else {
      print('Error en la solicitud');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          'Universidades por país.',
          style: TextStyle(
            fontFamily: 'Georgia',
          ),
        ),
        backgroundColor: Colors.blue[200],
      ),
      backgroundColor: Color.fromARGB(255, 209, 172, 148),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  pais = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre de un país en inglés.',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                obtenerUnis(pais);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: unis.length,
                itemBuilder: (context, index) {
                  var universidad = unis[index];
                  var nombre = universidad['name'];
                  var dominios = universidad['domains'];
                  var paginaWeb =
                      universidad['web_pages'][0] ?? 'No disponible';
                  AbrirWeb abrirWeb = AbrirWeb();
                  return Card(
                    child: ListTile(
                      title: Text(nombre),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dominios: ${dominios.join(', ')}'),
                          Text('Página web: $paginaWeb'),
                        ],
                      ),
                      onTap: () {
                        abrirWeb.abrirPagWeb(Uri.parse(paginaWeb));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
