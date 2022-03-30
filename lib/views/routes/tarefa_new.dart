import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';
import 'package:taredas_api/views/util/appBar.dart';
import 'package:intl/intl.dart';

class TaferaNew extends StatefulWidget {
  const TaferaNew({Key? key}) : super(key: key);

  @override
  State<TaferaNew> createState() => _TaferaNewState();
}

class _TaferaNewState extends State<TaferaNew> {
  ConfigApi api = ConfigApi();
  late Tarefa tarefa;

  final _tituloController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tarefa = Tarefa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Nova Tarefa"),
      backgroundColor: const Color(0xff1CB273),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffEEEEEE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tituloController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                labelText: "Titulo",
              ),
              validator: (String? value) {
                return value != null
                    ? "Campo obrigatório, preencher antes de salvar"
                    : null;
              },
            ),
            TextFormField(
              controller: _descController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                labelText: "Descrição",
              ),
              validator: (String? value) {
                return value != null
                    ? "Campo obrigatório, preencher antes de salvar"
                    : null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1CB273),
        onPressed: () {
          if (_tituloController.text != null && _descController.text != null) {
            tarefa.titulo = _tituloController.text;
            tarefa.desc = _descController.text;
            tarefa.isDone = false;
            final dataDeCriacaoDaTarefa = DateTime.now();
            tarefa.dataTarefa =
                DateFormat("dd/MM/yyyy").format(dataDeCriacaoDaTarefa);
            Navigator.pop(context, tarefa);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
