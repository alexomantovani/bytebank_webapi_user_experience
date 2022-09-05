class Contact {
  final int id;
  final String nome;
  final int numeroConta;

  Contact(this.id, this.nome, this.numeroConta);

  Contact.fromJson(Map<String, dynamic> json)
      : id = 0,
        nome = json['name'],
        numeroConta = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'accountNumber': numeroConta,
      };

  @override
  String toString() {
    return 'Contact{id: $id, name: $nome, numeroConta: $numeroConta}';
  }
}
