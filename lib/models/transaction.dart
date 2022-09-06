import 'package:bytebank_persistence/models/contact.dart';

class Transaction {
  final String id;
  final double valor;
  final Contact contato;

  Transaction(this.id, this.contato, this.valor);

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        contato = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{valor: $valor, contact: $contato}';
  }
}
