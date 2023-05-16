import '../Models/Quote.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  Future<List<Quote>?> getQuotes() async {
    var client = http.Client();

    var uri = Uri.parse('https://type.fit/api/quotes');
    var response = await client.get(uri);
    if(response.statusCode ==200) {
      var json = response.body;
      return quoteFromJson(json);
    }

  }
}