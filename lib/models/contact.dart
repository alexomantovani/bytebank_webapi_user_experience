class Contact {
  final String nome;
  final int numeroContal;

  Contact(this.nome, this.numeroContal);

  @override
  String toString() {
    return 'Contact{name: $nome, numeroConta: $numeroContal}';
  }
}
