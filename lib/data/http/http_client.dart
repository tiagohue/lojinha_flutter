import "package:http/http.dart" as http;

abstract class IHttpClient {
  Future get({required String url});

  Future post({required String url, required String body});

  Future delete({required String url, required String id});
}

class HttpClient extends IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future post({required String url, required String body}) {
    return client.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
  }

  @override
  Future delete({required String url, required String id}) async {
    final response = await http.delete(Uri.parse("$url/$id"));

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar pedido...");
    }
  }
}
