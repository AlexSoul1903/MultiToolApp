import 'package:flutter/material.dart';
import 'package:multitoolapp/Views/DeterminaEdad.dart';
import 'package:multitoolapp/Views/DeterminaUniPais.dart';
import 'package:multitoolapp/Views/WordPress.dart';
import 'DetectGenero.dart';
import 'NavBar.dart';
import 'Views/Clima.dart';
import 'Views/Contratame.dart';

//Alex Manuel Frias Molina.
//2021-1954.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiTool App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        ).copyWith(
          secondary: Colors.white,
          onSecondary: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'MultiTool App'),
        '/DeterminaEdad': (context) => DeterminaEdad(),
        '/Contratame': (context) => Contratame(),
        '/DeterminaUniPais': (context) => DeterminaUniPais(),
        '/Clima': (context) => Clima(),
        '/WordPress': (context) => WordPress(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/imgs/Tool.jpg',
              height: 200,
              width: 200,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            DetectGenero(),
          ],
        ),
      ),
    );
  }
}
