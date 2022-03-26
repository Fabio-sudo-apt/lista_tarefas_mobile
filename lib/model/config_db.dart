import 'dart:async';
import 'dart:core';
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

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitulo: titulo,
      columnDesc: desc,
      columnDataTarefa: dataTarefa
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Tarefa.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    titulo = map[columnTitulo];
    desc = map[columnDesc];
    dataTarefa = map[columnDataTarefa];
  }

  @override
  String toString() {
    return 'ID: $id, Nome: $titulo, Email: $desc, phone: $dataTarefa';
  }
}

class ConfigApi {
  static final ConfigApi _instance = ConfigApi.internal();

  factory ConfigApi() => _instance;

  ConfigApi.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializaDB();
      return _db;
    }
  }

  Future<Database> inicializaDB() async {
    final p = await getDatabasesPath();
    String path = join(p, "bancotarefas.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE $tarefaTable(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitulo TEXT,
        $columnDesc TEXT,
        $columnDataTarefa TEXT
      )""");
    });
  }

  Future<List<Tarefa>> listaDeTarefas() async {
    Database? tarefaDB = await db;
    List<Map<String, dynamic>> map =
        await tarefaDB!.rawQuery("SELECT * FROM $tarefaTable");
    List<Tarefa> tarefas = [];

    for (Map<String, dynamic> tarefa in map) {
      tarefas.add(Tarefa.fromMap(tarefa));
    }
    return tarefas;
  }

  Future<Tarefa> salvaTarefa(Tarefa tarefa) async {
    Database? tarefaDB = await db;
    tarefa.id = await tarefaDB!.insert(tarefaTable, tarefa.toMap());
    return tarefa;
  }

  Future<int> delete(int tarefaID) async {
    Database? tarefaDB = await db;
    return await tarefaDB!
        .delete(tarefaTable, where: "$columnId = ?", whereArgs: [tarefaID]);
  }

  Future<int> atualizaTarefa(Tarefa tarefa) async {
    Database? tarefaDB = await db;
    return await tarefaDB!.update(
      tarefaTable,
      tarefa.toMap(),
      where: "$columnId = ?",
      whereArgs: [tarefa.id],
    );
  }

  Future<Tarefa?> getTarefa(int tarefaID) async {
    Database? tarefaDB = await db;
    List<Map<String, dynamic>> map = await tarefaDB!.query(
      tarefaTable,
      columns: [
        columnId,
        columnTitulo,
        columnDesc,
        columnDataTarefa,
      ],
      where: "$columnId = ?",
      whereArgs: [tarefaID],
    );
    if (map.isNotEmpty) {
      return Tarefa.fromMap(map.first);
    } else {
      return null;
    }
  }
}
