import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:lojinha_flutter/widgets/pages/create_page.dart';
import 'package:lojinha_flutter/widgets/pages/details_page.dart';
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
                      ).then((_) => provider.carregarProdutos());
                    },
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.all(8.0),
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
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedText(
                                text: Text(
                                  NumberFormat.currency(
                                    locale: 'pt_BR',
                                    symbol: 'R\$',
                                  ).format(produto.price),

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
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 97, 179, 247),
                              ),
                              child: IconButton(
                                color: Colors.black,
                                onPressed: () {
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
                                            provider.deletarProduto(produto.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Sim"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.close),
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
