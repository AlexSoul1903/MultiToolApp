import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

//AlexSoul1903.
//Matricula: DEMO-ID.

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('AlexSoul1903'),
            accountEmail: Text('74164246+AlexSoul1903@users.noreply.github.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: const Icon(Icons.person, size: 48),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: const Text('Home.'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(
              Icons.accessibility,
              color: Colors.deepPurple,
            ),
            title: const Text('Determina Edad.'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/DeterminaEdad'),
          ),
          ListTile(
            leading: const Icon(Icons.school, color: Colors.amber),
            title: const Text('Detemina Universidaes por Pais.'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/DeterminaUniPais'),
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny, color: Colors.red),
            title: const Text('Clima.'),
            onTap: () => Navigator.pushReplacementNamed(context, '/Clima'),
          ),
          ListTile(
            leading: const Icon(Icons.newspaper, color: Colors.black),
            title: const Text('WordPress Atlus.'),
            onTap: () => Navigator.pushReplacementNamed(context, '/WordPress'),
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.blueAccent),
            title: const Text('Contratame.'),
            onTap: () => Navigator.pushReplacementNamed(context, '/Contratame'),
          ),
        ],
      ),
    );
  }
}
