import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static String movieNightBaseUrl = 'https://movie-night-api.onrender.com';
  static String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = '12b2f23a6c155146ef902104951e3b73';

  static startSession(String? deviceId) async {
    var response = await http
        .get(Uri.parse('$movieNightBaseUrl/start-session?device_id=$deviceId'));
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> joinSession(String code) async {
    final response =
        await http.get(Uri.parse('$movieNightBaseUrl/join-session?code=$code'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse response body and return
    } else {
      throw Exception('Failed to join session');
    }
  }
static Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final url = '$tmdbBaseUrl/movie/$movieId?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse response body and return movie details
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }
}

