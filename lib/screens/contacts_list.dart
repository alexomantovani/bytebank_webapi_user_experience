import 'package:bytebank_persistence/database/app_database.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';
import '/models/contact.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: findAll(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando')
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contatos = snapshot.data!;
              return ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, index) {
                  final Contact contato = contatos[index];
                  return _ContatacItem(contato);
                },
              );
            default:
          }
          return const Text('Erro Desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => const ContactForm(),
              ),
            )
            .then((novoContato) => debugPrint(novoContato.toString())),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _ContatacItem extends StatelessWidget {
  final Contact contato;

  const _ContatacItem(
    this.contato, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contato.nome,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contato.numeroContal.toString(),
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
