import 'dart:convert';

List<Quote> quoteFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String userModelToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  Quote({
    required this.text,
    required this.author,

  });

  String text;
  String author;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
      text: json["text"],
      author: json["author"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "author": author,
  };
}