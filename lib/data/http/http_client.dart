import "dart:convert";

import "package:http/http.dart" as http;
import "package:lojinha_flutter/data/http/exceptions.dart";

abstract class IHttpClient {
  Future get({required String url});

  Future post({required String url, required Map<String, dynamic> body});

  Future put({required String url, required Map<String, dynamic> body});

  Future delete({required String url, required String id});
}

class HttpClient extends IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida...");
    } else {
      throw Exception("Não foi possível carregar os produtos...");
    }
  }

  @override
  Future post({required String url, required Map<String, dynamic> body}) async {
    final response = await client.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Erro ao criar produto...");
    }
  }

  @override
  Future put({required String url, required Map<String, dynamic> body}) async {
    final response = await client.put(
      Uri.parse("$url/${body["id"]}"),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 404) {
      throw Exception("Erro ao atualizar produto não encontrado...");
    } else if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar produto...");
    }
  }

  @override
  Future delete({required String url, required String id}) async {
    final response = await client.delete(Uri.parse("$url/$id"));

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar produto...");
    }
  }
}
