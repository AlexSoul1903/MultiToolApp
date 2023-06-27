import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multitoolapp/NavBar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import '../util/AbrirWeb.dart';

class WordPress extends StatefulWidget {
  @override
  _WordPressState createState() => _WordPressState();
}

class _WordPressState extends State<WordPress> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://atlus.com/wp-json/wp/v2/posts?per_page=3'));

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    } else {
      throw Exception('Error al obtener las publicaciones');
    }
  }

  AbrirWeb abrirWeb = AbrirWeb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Publicaciones'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return ListTile(
            title: Text(
              post['title']['rendered'],
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              post['excerpt']['rendered'],
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 18,
              ),
            ),
            trailing: ElevatedButton(
              child: Text('Visitar'),
              onPressed: () {
                abrirWeb.abrirPagWeb(Uri.parse(post['link']));
              },
            ),
          );
        },
      ),
    );
  }
}
