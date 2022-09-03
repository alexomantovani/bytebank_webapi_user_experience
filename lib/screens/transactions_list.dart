import 'package:flutter/material.dart';

import 'package:bytebank_persistence/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({super.key});

  final List<Transaction> transactions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final Transaction transaction = transactions[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(
                transaction.valor.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                transaction.contato.numeroContal.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
