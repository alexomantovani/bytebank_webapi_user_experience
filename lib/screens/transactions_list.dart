import 'package:flutter/material.dart';

import '../components/centered_message.dart';
import '../components/progress.dart';
import '../http/webclients/transaction_webclient.dart';
import '/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({super.key});

  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: const <Transaction>[],
        future: _webClient.findAllWebClient(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data!;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
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
                            transaction.contato.numeroConta.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return const CenteredMessage(
                message: 'No transactions found',
                icon: Icons.warning,
              );
          }

          return const CenteredMessage(message: 'Unknown error');
        },
      ),
    );
  }
}
