import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';
import 'package:taredas_api/views/routes/alertDailog.dart';
import 'package:taredas_api/views/routes/tarefa_new.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

AppBar appBar(String titulo) {
  return AppBar(
    title: Text(
      titulo,
      style: const TextStyle(
        color: Color(0xffFFFFFF),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    toolbarHeight: 80.0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}

Container body(List<Tarefa> tarefas, Function atualizaTela, ConfigApi api) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: boxDecorationBody(),
    child: ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (context, index) {
        return getContainer(context, index, tarefas, atualizaTela, api);
      },
    ),
  );
}

BoxDecoration boxDecorationBody() {
  return const BoxDecoration(
    color: Color(0xffEEEEEE),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    ),
  );
}

Container getContainer(
  BuildContext context,
  int index,
  List<Tarefa> tarefas,
  Function atualizaTela,
  ConfigApi api,
) {
  return Container(
    margin: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          offset: Offset(5, 10),
          blurRadius: 80,
          color: Color.fromARGB(50, 0, 0, 0),
        )
      ],
    ),
    child: GestureDetector(
      onLongPress: () {
        print("Test onLongPress $index"); // Fazer amanhã
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) async{
                await editTarefa(context, tarefas[index]);
                atualizaTela();
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.blueAccent,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              flex: 2,
              onPressed: (context) async {
                await api.delete(tarefas[index].id!);
                tarefas.removeAt(index);
                atualizaTela();
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: listTile(tarefas, index, api, atualizaTela, context),
      ),
    ),
  );
}

Future editTarefa(BuildContext context, Tarefa editedTask) async {
  await showDialog<Tarefa>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDailog(tesk: editedTask);
    },
  );
}

ListTile listTile(
  List<Tarefa> tarefas,
  int index,
  ConfigApi api,
  Function atualizaTela,
  BuildContext context,
) {
  final tesk = tarefas[index];
  bool? teskNew = tesk.isDone;
  return ListTile(
    onTap: () {},
    title: Text(
      tesk.titulo!,
      style: TextStyle(
        color: const Color(0xff414C64),
        decoration:
            tesk.isDone! ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    ),
    subtitle: Text(
      tesk.dataTarefa!,
      style: const TextStyle(
        color: Color(0xff414C64),
      ),
    ),
    leading: GestureDetector(
      onTap: () async {
        tesk.isDone = !(teskNew!);
        await api.atualizaTarefa(tesk);
        atualizaTela();
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: tesk.isDone!
            ? const AssetImage("assets/confirm-circle_normal-green.png")
            : const AssetImage("assets/confirm-circle_normal.png"),
      ),
    ),
  );
}

FloatingActionButton buttonFloat(
  BuildContext context,
  ConfigApi api,
  Function atualizaTela,
) {
  return FloatingActionButton(
    onPressed: () async {
      Tarefa? newTarefa = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const TaferaNew()),
        ),
      );
      if (newTarefa == null) return;
      api.salvaTarefa(newTarefa);
      atualizaTela();
    },
    backgroundColor: const Color(0xff1CB273),
    child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
  );
}
