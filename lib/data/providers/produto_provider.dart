import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';
import 'package:lojinha_flutter/data/repositories/produto_repository.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoRepository repo;

  List<ProdutoModel> produtos = [];
  bool carregando = false;
  String? erro;

  ProdutoProvider({required this.repo});

  Future<void> carregarProdutos() async {
    carregando = true;
    notifyListeners();

    try {
      produtos = await repo.getProdutos();
      erro = null;
    } catch (e) {
      erro = e.toString();
    }

    carregando = false;
    notifyListeners();
  }
}
