import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/components/response_dialog.dart';
import '/components/transaction_auth_dialog.dart';
import '/models/contact.dart';
import '/models/transaction.dart';
import '/http/webclients/transaction_webclient.dart';

class TransactionForm extends StatefulWidget {
  final Contact contato;

  const TransactionForm({required this.contato, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

final TransactionWebClient _webClient = TransactionWebClient();

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  String transactionId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contato.nome,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numeroConta.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final double value = double.parse(_valueController.text);

                      final Transaction transactionCreated = Transaction(transactionId, widget.contato, value);

                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                            onConfirm: (password) => _save(transactionCreated, password, context),
                          );
                        },
                      );
                    },
                    child: const Text('Transferência'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );
    _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
        context: context,
        builder: (contextDialog) {
          return const SuccessDialog('Successful transaction');
        },
      );
      Navigator.pop(context);
    }
  }
}

Future<Transaction> _send(
  Transaction transactionCreated,
  String password,
  BuildContext context,
) async {
  final Transaction transaction = await _webClient.save(transactionCreated, password).catchError((e) {
    _showFailureMessage(context, message: e.message);
  }, test: (e) => e is HttpException).catchError((e) {
    _showFailureMessage(context, message: 'timeout submitting the transaction');
  }, test: (e) => e is TimeoutException).catchError((e) {
    _showFailureMessage(context);
  });
  return transaction;
}

void _showFailureMessage(
  BuildContext context, {
  String message = 'Unknown error',
}) {
  showDialog(
    context: context,
    builder: (contextDialog) {
      return FailureDialog(message);
    },
  );
}
