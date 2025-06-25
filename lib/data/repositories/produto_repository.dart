import 'package:lojinha_flutter/data/http/http_client.dart';
import 'package:lojinha_flutter/data/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos();

  Future<void> criarProduto(ProdutoModel produtoModel);

  Future<void> atualizarProduto(ProdutoModel produto);

  Future<void> deletarProduto(String id);
}

class ProdutoRepository implements IProdutoRepository {
  final IHttpClient client;

  ProdutoRepository({required this.client});

  final baseApiUrl =
      "https://685bfd3189952852c2dbc8fe.mockapi.io/lojinha/api/products";

  @override
  Future<List<ProdutoModel>> getProdutos() async {
    final List<ProdutoModel> produtos = [];

    final body = await client.get(url: baseApiUrl);
    body.map((item) {
      final ProdutoModel produto = ProdutoModel.fromMap(item);

      produtos.add(produto);
    }).toList();

    return produtos;
  }

  @override
  Future<void> criarProduto(ProdutoModel produtoModel) async {
    await client.post(url: baseApiUrl, body: produtoModel.toMap());
  }

  @override
  Future<void> atualizarProduto(ProdutoModel produto) async {
    client.put(url: baseApiUrl, body: produto.toMap());
  }

  @override
  Future<void> deletarProduto(String? id) async {
    if (id != null) {
      await client.delete(url: baseApiUrl, id: id);
    } else {
      throw Exception("Id não pode ser nulo...");
    }
  }
}
