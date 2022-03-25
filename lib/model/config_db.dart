
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tarefaTable = "tarefaTable";
const String columnId = "columnId";
const String columnTitulo = "columnTitulo";
const String columnDesc = "columnDesc";
const String columnDataTarefa = "columnDataTarefa";

class Tarefa {
  int? id;
  String? titulo;
  String? desc;
  String? dataTarefa;

  Tarefa();

  Map toMap(){
    var map = <String, dynamic>{
      columnId: id,
      columnTitulo: titulo,
      columnDesc: desc,
      columnDataTarefa: dataTarefa
    };
    if (id != null){
      map[columnId] = id;
    }
    return map;
  }

  Tarefa.fromMap(Map <String, dynamic> map){
    id = map[columnId];
    titulo = map[columnTitulo];
    desc = map[columnDesc];
    dataTarefa = map[columnDataTarefa];
  }
}

class ConfigApi {
  Database? db;

  inicializa_db() async{
    final p = await getDatabasesPath();
    String path = join(p, "bancotarefas.db");

    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async{
      await db.execute("""CREATE TABLE $tarefaTable(
        $columnId integer primary key autoincrement,
        
      )""");
    });
  }



}