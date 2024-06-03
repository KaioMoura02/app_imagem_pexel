import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class ApiService {
  var logger = Logger();
  final String apiKey = dotenv.get('PEXELS_API_KEY');
  final String baseUrl = 'https://api.pexels.com/v1';

  Future<List<dynamic>> fetchImages(String categoria) async {
    var url = Uri.parse('$baseUrl/search?query=$categoria&per_page=20&locale=pt-BR');
    var response = await http.get(url, headers: {
      'Authorization': apiKey
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData['photos'];
    } else {
      throw Exception('Failed to load images from Pexels');
    }
  }

  Future<List<dynamic>> fetchPhotos(String categories) async {
    var categoriesList = categories.split(' ');
    List<dynamic> categorizedImages = [];

    for (var category in categoriesList) {
      var url = Uri.parse('$baseUrl/search?query=$category&per_page=1&locale=pt-BR');
      var response = await http.get(url, headers: {'Authorization': apiKey});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var photo = data['photos'][0];
        categorizedImages.add({
          'category': capitalize(category),
          'image': photo['src']['large2x']
        });
      } else {
        throw Exception('Failed to load images');
      }
    }
    return categorizedImages;
  }

}


String capitalize(String texto) {
  if (texto.isEmpty) return "";
  return texto.toLowerCase().split(' ').map((word) => word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1))
    .where((word) => word.isNotEmpty)
    .join(' ');
}