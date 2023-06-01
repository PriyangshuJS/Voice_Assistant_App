import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:assistant/secret.dart';

class OpenAiServices {
  final List<Map<String, String>> messages = [];
  // ignore: non_constant_identifier_names
  Future<String> IsArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OpenApiSecretKey"
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no."
            }
          ]
        }),
      );
      //print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["messages"]["content"];
        content = content.trim();

        switch (content) {
          case "Yes":
          case "yes":
          case "Yes.":
          case "yes.":
            final res = await DallE(prompt);
            return res;
          default:
            final res = await ChatGPT(prompt);
            return res;
        }
      }
      return "An Internal ERROR occured !";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> ChatGPT(String prompt) async {
    messages.add({
      "role": "user",
      "context": prompt,
    });
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OpenApiSecretKey"
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["messages"]["content"];
        content = content.trim();
        messages.add({
          "role": "assistence",
          "messages": content,
        });

        return content;
      }
      return "An Internal ERROR occured !";
    } catch (e) {
      return e.toString();
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> DallE(String prompt) async {
    return "D";
  }
}
