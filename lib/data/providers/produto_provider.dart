import 'package:flutter/material.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';
import 'package:lojinha_flutter/data/repositories/produto_repository.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoRepository repo;

  List<ProdutoModel> produtos = [];
  bool carregando = false;
  String? erro;
  ProdutoModel? produtoSelec;

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

  Future<void> criarProduto(ProdutoModel produto) async {
    await repo.criarProduto(produto);
    await carregarProdutos();
    notifyListeners();
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    await repo.atualizarProduto(produto);
    await carregarProdutos();
    notifyListeners();
  }

  Future<void> deletarProduto(String? id) async {
    await repo.deletarProduto(id);
    await carregarProdutos();
    notifyListeners();
  }
}
