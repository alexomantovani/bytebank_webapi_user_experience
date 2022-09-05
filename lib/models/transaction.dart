import 'package:bytebank_persistence/models/contact.dart';

class Transaction {
  final double valor;
  final Contact contato;

  Transaction(this.contato, this.valor);

  Transaction.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        contato = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{valor: $valor, contact: $contato}';
  }
}
