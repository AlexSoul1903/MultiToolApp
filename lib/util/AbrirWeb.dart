import 'package:url_launcher/url_launcher.dart';

//Alex Manuel Frias Molina.
//2021-1954

class AbrirWeb {
  Future<void> abrirPagWeb(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }
}
