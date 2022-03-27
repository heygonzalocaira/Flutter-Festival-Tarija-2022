import 'package:flutter/material.dart';
import 'package:flutter_festival_tarija/model/gif.dart';
import 'package:flutter_festival_tarija/service/gif_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Gif> listGif = [];

  @override
  void initState() {
    getGifFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Festival Tarija'),
        ),
        body: FutureBuilder(
          future: GifService().getGif(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: putListGift(listGif),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  putListGift(List<Gif> data) {
    List<Widget> listgif = [];
    for (var gif in data) {
      listgif.add(GifCard(
        name: gif.name,
        url: gif.url,
      ));
    }
    return listgif;
  }

  getGifFromApi() async {
    listGif = await GifService().getGif();
  }
}

class GifCard extends StatelessWidget {
  GifCard({
    required this.name,
    required this.url,
    Key? key,
  }) : super(key: key);
  String name;
  String url;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(name),
          Image.network(
            url,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
