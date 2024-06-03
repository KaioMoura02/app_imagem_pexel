import 'package:app_imagem/widgets/grid_images.dart';
import 'package:app_imagem/widgets/search_button.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Imagens do Pexels'),
        elevation: 2,
        shadowColor: const Color(0xFFFAFAFA),
      ),
      body: const Center(
        child: ImageGrid(),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          showSearch(context: context, delegate: CustomSearchDelegate(),);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}