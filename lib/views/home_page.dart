import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';
import 'package:taredas_api/views/util/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConfigApi api = ConfigApi();
  List<Tarefa> tarefas = [];

  @override
  void initState() {
    super.initState();
    atualizaTela();
  }

  void atualizaTela() {
    api.listaDeTarefas().then((value) {
      setState(() {
        tarefas = value;
        //print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("TAREFAS"),
      backgroundColor: const Color(0xff1CB273),
      body: body(tarefas, atualizaTela, api),
      floatingActionButton: buttonFloat(context, api, atualizaTela),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}