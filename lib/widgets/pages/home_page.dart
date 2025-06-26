import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:lojinha_flutter/widgets/pages/create_page.dart';
import 'package:lojinha_flutter/widgets/pages/details_page.dart';
import 'package:lojinha_flutter/widgets/pages/edit_page.dart';
import 'package:lojinha_flutter/widgets/standad_container.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outlined_text/outlined_text.dart';

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
        title: Text("Lojinha - Estoque"),
      ),
      body: Center(
        child: provider.carregando
            ? Center(child: CircularProgressIndicator())
            : provider.erro != null
            ? Center(child: Text('Erro: ${provider.erro}'))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: provider.produtos.length,
                itemBuilder: (context, index) {
                  final produto = provider.produtos[index];

                  return GestureDetector(
                    onTap: () {
                      provider.produtoSelec = produto;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailsPage()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: Image.network(
                                produto.image,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(MdiIcons.emoticonSadOutline),
                                    Text("Link bugado..."),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: OutlinedText(
                              text: Text(
                                produto.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              strokes: [
                                OutlinedTextStroke(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StandardContainer(
                                  child: IconButton(
                                    onPressed: () async {
                                      if (produto.quantity <= 0) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Um produto não pode ter quantidade menor que 0!",
                                            ),
                                          ),
                                        );

                                        return;
                                      }

                                      final produtoNovo = ProdutoModel(
                                        title: produto.title,
                                        price: produto.price,
                                        quantity: produto.quantity - 1,
                                        category: produto.category,
                                        description: produto.description,
                                        image: produto.image,
                                        id: produto.id,
                                      );

                                      await provider.atualizarProduto(
                                        produtoNovo,
                                      );
                                      await provider.carregarProdutos();
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: OutlinedText(
                                    text: Text(
                                      produto.quantity.toString(),

                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                    ),
                                    strokes: [
                                      OutlinedTextStroke(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                StandardContainer(
                                  child: IconButton(
                                    onPressed: () async {
                                      final produtoNovo = ProdutoModel(
                                        title: produto.title,
                                        price: produto.price,
                                        quantity: produto.quantity + 1,
                                        category: produto.category,
                                        description: produto.description,
                                        image: produto.image,
                                        id: produto.id,
                                      );

                                      await provider.atualizarProduto(
                                        produtoNovo,
                                      );
                                      await provider.carregarProdutos();
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: StandardContainer(
                              child: PopupMenuButton(
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    value: "editar",
                                    child: Text("Editar"),
                                  ),
                                  PopupMenuItem(
                                    value: "deletar",
                                    child: Text("Deletar"),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "editar") {
                                    provider.produtoSelec = produto;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditPage(),
                                      ),
                                    ).then((_) => provider.carregarProdutos());
                                  } else if (value == "deletar") {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("Tem certeza?"),
                                        content: Text(
                                          "Tem certeza que quer deletar o produto \"${produto.title}\"",
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Não"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              provider.deletarProduto(
                                                produto.id,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text("Sim"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 97, 179, 247),
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
