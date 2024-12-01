import 'package:dio/dio.dart';

class JokeService {
  final String _baseUrl = 'https://v2.jokeapi.dev/joke';
  final Dio _dio = Dio();

  // List of available joke categories
  final List<String> categories = [
    'Programming',
    'Misc',
    'Dark',
    'Pun',
  ];

  Future<List<String>> fetchJokesRaw({String category = 'Programming'}) async {
    try {
      // Validate the category
      if (!categories.contains(category)) {
        throw Exception('Invalid joke category');
      }

      final response = await _dio.get(
        '$_baseUrl/$category',
        queryParameters: {
          'amount': 5,
          'type': 'single',
          'blacklistFlags': 'nsfw,religious,political,racist,sexist,explicit',
        },
      );

      print(response.toString());

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch jokes');
      }

      final List<dynamic> jokesJson = response.data['jokes'];
      return jokesJson.map((joke) => joke['joke'] as String).toList();
    } catch (e) {
      throw Exception('Failed to load jokes: ${e.toString()}');
    }
  }
}