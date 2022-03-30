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

  final _focusTitulo = FocusScopeNode();
  final _focusDesc = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    tarefa = Tarefa();
  }

  @override
  void dispose() {
    super.dispose();
    _tituloController.dispose();
    _descController.dispose();

    _focusTitulo.dispose();
    _focusDesc.dispose();
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
              focusNode: _focusTitulo,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                labelText: "Titulo",
              ),
            ),
            TextFormField(
              controller: _descController,
              focusNode: _focusDesc,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                labelText: "Descrição",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1CB273),
        onPressed: () {
          if (_tituloController.text.isEmpty || _descController.text.isEmpty) {
            if (_tituloController.text.isEmpty) {
              FocusScope.of(context).requestFocus(_focusTitulo);
            } else {
              FocusScope.of(context).requestFocus(_focusDesc);
            }
          } else {
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
