import 'package:bytebanck_flutter2/dao/Contato_dao.dart';
import 'package:bytebanck_flutter2/database/app_database.dart';
import 'package:bytebanck_flutter2/models/contato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controladorCampoNomeCompleto = TextEditingController();

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final ContatoDao _dao = ContatoDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorCampoNomeCompleto,
                decoration: InputDecoration(labelText: 'Nome completo'),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorCampoNumeroConta,
                decoration: InputDecoration(labelText: 'Numero da conta'),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        final String nome = _controladorCampoNomeCompleto.text;
                        final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);

                        final contato = Contato(0, nome, numeroConta);
                        _dao.save(contato).then((value) => Navigator.pop(context, contato));
                      },
                      child: Text('Confirmar'))),
            )
          ])),
    );
  }
}
