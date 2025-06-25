import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoProvider>(context, listen: false);
    final produtoSelec = provider.produtoSelec!;

    titleController.text = produtoSelec.title;
    priceController.text = produtoSelec.price.toString();
    categoryController.text = produtoSelec.category;
    descriptionController.text = produtoSelec.description;
    imageController.text = produtoSelec.image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(produtoSelec.title),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Url da imagem'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final price = double.tryParse(priceController.text) ?? 0.0;
                final category = categoryController.text.trim();
                final description = descriptionController.text.trim();
                final image = imageController.text.trim();

                if (title.isEmpty || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Preencha pelo menos os campos \"título\" e \"preço\" corretamente!",
                      ),
                    ),
                  );
                  return;
                }

                final produto = ProdutoModel(
                  title: title,
                  price: price,
                  category: category,
                  description: description,
                  image: image,
                );

                produto.id = produtoSelec.id;
                await provider.atualizarProduto(produto);

                provider.produtoSelec = produto;

                Navigator.pop(context);
              },
              child: const Text('Atualizar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
