import 'package:app_imagem/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

Future<List<dynamic>> fetchImagesFromPhotographer(String photographerName) async {
  List<dynamic> list = await ApiService().fetchImages(photographerName);
  return list;
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Pesquisar categorias';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchImagesFromPhotographer(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final images = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.38),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                var item = images[index];
                return _buildItem(item['src']['large2x'], item['photographer'], context);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar imagens: ${snapshot.error}'));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        Container(),
      ],
    );
  }

  Widget _buildItem(String image, String author, BuildContext context) {
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
                image,
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8,),
            const Text('Foto de:', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(fontSize: 14),),
            Text(author, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ],
        )
      )
    );
  }

}
