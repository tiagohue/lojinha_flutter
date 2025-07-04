import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/http/http_client.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:lojinha_flutter/data/repositories/produto_repository.dart';
import 'package:lojinha_flutter/widgets/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProdutoProvider(
              repo: ProdutoRepository(client: HttpClient()),
            );
            provider.carregarProdutos();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              color: const Color.fromARGB(255, 97, 179, 247),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
