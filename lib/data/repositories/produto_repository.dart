import 'package:lojinha_flutter/data/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> get();
}

class ProdutoRepository implements IProdutoRepository {
  @override
  Future<List<ProdutoModel>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
