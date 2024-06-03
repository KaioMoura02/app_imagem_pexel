import 'package:app_imagem/services/api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CardAuthor extends StatefulWidget {
  final String author;
  const CardAuthor({super.key, required this.author});

  @override
  State<CardAuthor> createState() => _CardAuthorState();
}

class _CardAuthorState extends State<CardAuthor> {
  late Future<List<dynamic>> images;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    images = ApiService().fetchImages(widget.author);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: snapshot.data!.map((imageData) {
              if (imageData != null && imageData['src'] != null && imageData['src']['large'] != null) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.network(
                        imageData['src']['large'],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              } else {
                logger.e("Dados de imagem inválidos");
                return Container();
              }
            }).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
