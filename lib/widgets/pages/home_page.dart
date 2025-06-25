import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:lojinha_flutter/widgets/pages/create_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_grocery_store),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lojinha - Admin"),
      ),
      body: Center(
        child: provider.carregando
            ? Center(child: CircularProgressIndicator())
            : provider.erro != null
            ? Center(child: Text('Erro: ${provider.erro}'))
            : ListView.builder(
                itemCount: provider.produtos.length,
                itemBuilder: (context, index) {
                  final produto = provider.produtos[index];
                  return ListTile(
                    title: Text(produto.title),
                    subtitle: Text(produto.price.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        debugPrint("deletar");
                      },
                      icon: Icon(Icons.close),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => CreatePage()),
        ),
        tooltip: 'Criar produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
