import 'package:bytebanck_flutter2/dao/Contato_dao.dart';
import 'package:bytebanck_flutter2/models/contato.dart';
import 'package:bytebanck_flutter2/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContatoDao _dao = ContatoDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contatos')),
      body: FutureBuilder<List<Contato>>(
        initialData: [],
        future: Future.delayed(Duration(seconds: 1)).then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato>? contatos = snapshot.data as List<Contato>?;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contato = contatos![index];
                  return _contatoItem(contato);
                },
                itemCount: contatos?.length,
              );
          }
          return Text('Ocorreu um erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactForm()));
          // Force update (rebuild widget)
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _contatoItem extends StatelessWidget {
  late final Contato contato;

  _contatoItem(this.contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contato.nome, style: TextStyle(fontSize: 24.0)),
        subtitle: Text(contato.numeroConta.toString(), style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
