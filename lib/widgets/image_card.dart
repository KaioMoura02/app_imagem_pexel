import 'package:app_imagem/widgets/card_author.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String author;
  final Map<String, dynamic> imageData;
  const ImageCard({super.key, required this.author, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mais imagens de:'),
                  Text(author),
                ],
              ),
              content: SingleChildScrollView(
                child: CardAuthor(author: author),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: _buildItem(imageData, author, context),
    );
  }


  Widget _buildItem(var imageData, String author, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageData['image'],
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8,),
            const Text('Fotos de:', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(fontSize: 14),),
            Text(author, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ],
        )
      )
    );
  }

}