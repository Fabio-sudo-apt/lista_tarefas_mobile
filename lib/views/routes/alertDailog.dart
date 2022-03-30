import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';

class AlertDailog extends StatefulWidget {
  final Tarefa tesk;
  const AlertDailog({Key? key, required this.tesk}) : super(key: key);

  @override
  State<AlertDailog> createState() => _AlertDailogState();
}

class _AlertDailogState extends State<AlertDailog> {
  ConfigApi api = ConfigApi();

  final _tituloController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.tesk.titulo!;
    _descController.text = widget.tesk.desc!;
  }

  @override
  void dispose() {
    super.dispose();
    _tituloController.clear();
    _descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tituloController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              icon: Icon(Icons.title),
              labelText: "Titulo",
            ),
            onChanged: (text) {
              widget.tesk.titulo = _tituloController.text;
            },
          ),
          TextField(
            controller: _descController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              icon: Icon(Icons.description),
              labelText: "Descrição",
            ),
            onChanged: (text) {
              widget.tesk.desc = _descController.text;
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async{
            api.atualizaTarefa(widget.tesk);
            Navigator.pop(context);
          },
          child: const Text(
            "Salvar",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancelar",
           
          ),
        )
      ],
    );
  }
}
