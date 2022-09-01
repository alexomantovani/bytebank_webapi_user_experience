import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDao {
  static const String _tableName = 'contatos';
  static const String _id = 'id';
  static const String _numeroConta = 'numero_conta';
  static const String _nome = 'nome';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numeroConta INTEGER)';

  Future<int> save(Contact contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> mapaContato = _toMap(contato);
    return db.insert(_tableName, mapaContato);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> resultado = await db.query(_tableName);
    List<Contact> contatos = _toList(resultado);
    return contatos;
  }

  Future<int> update(Contact contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> mapaContato = _toMap(contato);
    return db.update(
      _tableName,
      mapaContato,
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(Contact contato) {
    final Map<String, dynamic> mapaContato = {};
    mapaContato[_nome] = contato.nome;
    mapaContato[_numeroConta] = contato.numeroContal;
    return mapaContato;
  }

  List<Contact> _toList(List<Map<String, dynamic>> resultados) {
    final List<Contact> contatos = [];
    for (Map<String, dynamic> resultado in resultados) {
      final Contact contato = Contact(
        resultado[_id],
        resultado[_nome],
        resultado[_numeroConta],
      );
      contatos.add(contato);
    }
    return contatos;
  }
}
