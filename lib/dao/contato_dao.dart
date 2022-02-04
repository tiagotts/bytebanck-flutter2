import 'package:bytebanck_flutter2/database/app_database.dart';
import 'package:bytebanck_flutter2/models/contato.dart';

class ContatoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numeroConta INTEGER)';

  static const String _tableName = 'contato';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numeroConta = 'numero_conta';

  Future<int> save(Contato contact) async {
    final dataBase = await getDatabase();
    final Map<String, dynamic> contactMap = Map();
    contactMap[_nome] = contact.nome;
    contactMap[_numeroConta] = contact.numeroConta;
    return dataBase.insert(_tableName, contactMap);
  }

  Future<List<Contato>> findAll() async {
    final dataBase = await getDatabase();
    final List<Contato> contatos = [];
    final List<Map<String, dynamic>> lista = await dataBase.query(_tableName);
    for (Map<String, dynamic> item in lista) {
      final Contato contato = Contato(item[_id], item[_nome], item[_numeroConta]);
      contatos.add(contato);
    }
    return contatos;
  }
}
