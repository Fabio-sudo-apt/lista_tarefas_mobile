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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Titulo: ${widget.tesk.titulo!}"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Descrição: ${widget.tesk.desc!}"),
          const Divider(),
          Text("A tarefa foi criada: ${widget.tesk.dataTarefa!}")
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Sair",
          ),
        )
      ],
    );
  }
}
