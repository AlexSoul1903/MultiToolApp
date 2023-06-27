import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../NavBar.dart';

class Clima extends StatefulWidget {
  @override
  _ClimaState createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _paisController = TextEditingController();
  String cityName = 'Santo Domingo';
  String paisN = 'República Dominicana';
  String paisCode = 'DO';
  String tiempoDesc = '';
  double temperatura = 0;
  String errorMessage = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchDatosClima();
    actualizarTiempo();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void actualizarTiempo() {
    const updateIntervalo =
        Duration(minutes: 1); // Intervalo de actualización de 1 minuto
    _timer = Timer.periodic(updateIntervalo, (_) {
      fetchDatosClima();
    });
  }

  Future<String> getCountryCode(String countryName) async {
    final response = await http
        .get(Uri.parse('https://restcountries.com/v3/name/$countryName'));
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonData is List && jsonData.isNotEmpty) {
      final datosPais = jsonData[0];
      final alpha2Code = datosPais['alpha2Code'];
      if (alpha2Code is String && alpha2Code.isNotEmpty) {
        return alpha2Code;
      }
    }
    return '';
  }

  Future<void> fetchDatosClima() async {
    final apiKey = '0d2848891c979d1746fa87b14b24c7b5';
    final apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName,$paisCode&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          tiempoDesc = jsonData['weather'][0]['description'];
          temperatura = jsonData['main']['temp'];
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Error al obtener el clima';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error de conexión';
      });
    }
  }

  Future<void> updateCodigoPais() async {
    final enteredCountry = _paisController.text.trim();
    if (enteredCountry.isNotEmpty) {
      final paisCode = await getCountryCode(enteredCountry);
      setState(() {
        this.paisCode = paisCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Clima'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/imgs/Clima.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _paisController,
                  decoration: InputDecoration(
                    labelText: 'País',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      paisN = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Ciudad',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateCodigoPais();
                    fetchDatosClima();
                  },
                  child: Text('Obtener Clima'),
                ),
                SizedBox(height: 20),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                if (errorMessage.isEmpty && tiempoDesc.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'Ciudad: $cityName',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'País: $paisN',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Descripción: $tiempoDesc',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Temperatura: $temperatura °C',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
