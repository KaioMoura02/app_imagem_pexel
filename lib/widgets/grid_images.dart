import 'package:app_imagem/services/api_service.dart';
import 'package:app_imagem/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key});

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  late Future<List<dynamic>> images;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    images = ApiService().fetchPhotos('gatos cachorros natureza cidade céu casa pessoas computador');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
        child: FutureBuilder<List>(
        future: images,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.38),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var imageData = snapshot.data![index];
                String author = imageData['category'];
                return ImageCard(author: author, imageData: imageData,);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

}
