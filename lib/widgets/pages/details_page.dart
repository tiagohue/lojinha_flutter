import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lojinha_flutter/data/providers/produto_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoProvider>(context, listen: false);
    final produtoSelec = provider.produtoSelec!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Detalhes"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                produtoSelec.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 300,
                child: Image.network(
                  fit: BoxFit.cover,
                  produtoSelec.image,
                  errorBuilder: (_, _, _) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.emoticonSadOutline),
                      const Text("Link bugado..."),
                    ],
                  ),
                ),
              ),
              Text(
                "Preço: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(produtoSelec.price)}",
              ),
              Text("Quantidade: ${produtoSelec.quantity}"),
              Text("Categoria: ${produtoSelec.category}"),
              Text("Descrição: ${produtoSelec.description}"),
              Text("Url da Imagem: ${produtoSelec.image}"),
            ],
          ),
        ),
      ),
    );
  }
}
