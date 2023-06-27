import 'package:url_launcher/url_launcher.dart';

//AlexSoul1903.
//DEMO-ID

class AbrirWeb {
  Future<void> abrirPagWeb(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }
}
