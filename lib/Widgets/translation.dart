import 'dart:convert';
import 'package:http/http.dart' as http;

class Translation{
  Future<String> translateText(String text, {String toLanguage = 'ar'}) async {
    final apiKey = 'AIzaSyCEQgYEAQ2rUrnIRiBSN8oVQAe0221YwnA';
    final apiUrl = 'https://translation.googleapis.com/language/translate/v2';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'q': text,
        'target': toLanguage,
        'key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final translatedText = data['data']['translations'][0]['translatedText'];
      return translatedText;
    } else {
      throw Exception('Failed to translate text. Status code: ${response.statusCode}');
    }
  }

}
Translation translate=Translation();

