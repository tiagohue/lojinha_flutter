import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Criar Produto"),
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
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                provider.criarProduto(
                  titleController.text,
                  double.parse(priceController.text),
                  categoryController.text,
                  descriptionController.text,
                );

                Navigator.pop(context);
              },
              child: const Text('Criar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
