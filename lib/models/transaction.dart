import 'package:bytebank_persistence/models/contact.dart';

class Transaction {
  final double valor;
  final Contact contato;

  Transaction(this.contato, this.valor);

  @override
  String toString() {
    return 'Transaction{valor: $valor, contact: $contato}';
  }
}
