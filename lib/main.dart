import 'package:app_imagem/widgets/grid_images.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_imagem/screen/main_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        '/grid_images': (context) => const ImageGrid(),
        '/main_screen': (context) => const MainScreen(),
      },
    );
  }
}
