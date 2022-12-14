import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../web_client.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAllWebClient() async {
    final Response response = await client.get(
      Uri.parse(baseUrl),
    );

    final List<dynamic> decodedJson = jsonDecode(response.body) as List;
    final List<Transaction> transactions = decodedJson.map((json) => Transaction.fromJson(json)).toList();

    return transactions;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(const Duration(seconds: 2));

    final Response response = await client.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting the transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
