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
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Adicionar Produto"),
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
            ElevatedButton(
              onPressed: () {
                debugPrint("Salvar");
              },
              child: const Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
