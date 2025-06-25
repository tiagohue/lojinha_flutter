import 'dart:convert';

import 'package:lojinha_flutter/data/http/exceptions.dart';
import 'package:lojinha_flutter/data/http/http_client.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos();

  Future<void> criarProduto(ProdutoModel produtoModel);

  Future<void> atualizarProduto(ProdutoModel produtoModel);

  Future<void> deletarProduto(String id);
}

class ProdutoRepository implements IProdutoRepository {
  final IHttpClient client;

  ProdutoRepository({required this.client});

  final baseUrl =
      "https://685bfd3189952852c2dbc8fe.mockapi.io/lojinha/api/products";

  @override
  Future<List<ProdutoModel>> getProdutos() async {
    final response = await client.get(url: baseUrl);

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final ProdutoModel produto = ProdutoModel.fromMap(item);

        produtos.add(produto);
      }).toList();

      return produtos;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida...");
    } else {
      throw Exception("Não foi possível carregar os produtos...");
    }
  }

  @override
  Future<void> criarProduto(ProdutoModel produtoModel) async {
    final response = await client.post(
      url: baseUrl,
      body: json.encode(produtoModel.toMap()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Erro ao criar produto...");
    }
  }

  @override
  Future<void> atualizarProduto(ProdutoModel produtoModel) {
    // TODO: implement atualizarProduto
    throw UnimplementedError();
  }

  @override
  Future<void> deletarProduto(String id) {
    // TODO: implement deletarProduto
    throw UnimplementedError();
  }
}
