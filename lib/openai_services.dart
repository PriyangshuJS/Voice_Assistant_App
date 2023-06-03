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
                  "Does the message: '$prompt' indicate a request to generate a picture, image, artwork, or any visual content? Please answer with 'yes' or 'no'."
            }
          ]
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = content.trim();
        print("ANSWER - $content");
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
    print("CHAT_GPT");
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
    print("DALL-E");
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OpenApiSecretKey"
        },
        body: jsonEncode({
          "prompt": prompt,
          "n": 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageurl = jsonDecode(res.body)["data"][0]["url"];
        imageurl = imageurl.trim();
        messages.add({
          "role": "assistant",
          "content": imageurl,
        });

        return imageurl;
      }
      return "An Internal ERROR occurred!";
    } catch (e) {
      return e.toString();
    }
  }
}
