class Contact {
  final int id;
  final String nome;
  final int numeroContal;

  Contact(this.id, this.nome, this.numeroContal);

  @override
  String toString() {
    return 'Contact{id: $id, name: $nome, numeroConta: $numeroContal}';
  }
}
