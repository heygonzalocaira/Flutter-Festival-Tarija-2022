import 'dart:convert';

import 'package:flutter_festival_tarija/Api/app_url.dart';
import 'package:flutter_festival_tarija/model/gif.dart';
import 'package:http/http.dart' as http;

class GifService {
  Future<List<Gif>> getGif() async {
    List<Gif> listGif = [];
    try {
      final response = await http.get(Uri.parse(AppUrl.baseUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        print(jsonData);
        for (var item in jsonData['data']) {
          listGif.add(Gif(item['title'], item['images']['downsized']['url']));
        }
        return listGif;
      } else {
        print("Que mensin");
        return listGif;
      }
    } catch (e) {
      return listGif;
    }
  }
}
