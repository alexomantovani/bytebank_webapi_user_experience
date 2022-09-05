import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '/models/contact.dart';
import '/models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    print('Request');
    print('url: ${data!.url}');
    // print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async {
    print('Response');
    print('status code: ${data!.statusCode}');
    // print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  Future<List<Transaction>> findAllWebClient() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Response response = await client
        .get(
          Uri.parse('http://192.168.0.9:8080/transactions'),
        )
        .timeout(const Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];

    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contatoJson = transactionJson["contact"];
      final Transaction transaction = Transaction(
        Contact(
          0,
          contatoJson["name"],
          contatoJson["accountNumber"],
        ),
        transactionJson["value"],
      );
      transactions.add(transaction);
    }
    return transactions;
  }
}
