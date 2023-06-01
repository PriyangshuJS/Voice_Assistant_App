import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:assistant/secret.dart';

class OpenAiServices {
  final List<Map<String, String>> messages = [];

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

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = content.trim();

        switch (content) {
          case "Yes":
          case "yes":
          case "Yes.":
          case "yes.":
            final dalleRes = await DallE(prompt);
            return dalleRes;
          default:
            final chatGptRes = await ChatGPT(prompt);
            return chatGptRes;
        }
      }
      return "An Internal ERROR occurred!";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> ChatGPT(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
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
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = content.trim();
        messages.add({
          "role": "assistant",
          "content": content,
        });

        return content;
      }
      return "An Internal ERROR occurred!";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> DallE(String prompt) async {
    return "D";
  }
}
