import '/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contatos('
          'id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'numero_conta INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contatoMap = {};
    contatoMap['nome'] = contact.nome;
    contatoMap['numero_conta'] = contact.numeroContal;
    return db.insert('contatos', contatoMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contatos').then((mapas) {
      final List<Contact> contatos = [];
      for (Map<String, dynamic> mapa in mapas) {
        final Contact contato = Contact(
          mapa['id'],
          mapa['nome'],
          mapa['numero_conta'],
        );
        contatos.add(contato);
      }
      return contatos;
    });
  });
}
