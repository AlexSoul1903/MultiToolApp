import 'package:url_launcher/url_launcher.dart';


class AbrirWeb {
  Future<void> abrirPagWeb(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }
}
