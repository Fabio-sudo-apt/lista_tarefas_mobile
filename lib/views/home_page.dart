import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';
import 'package:taredas_api/views/routes/tarefa_new.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("TAREFAS"),
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
        child: ListView.builder(
          itemCount: tarefas.length,
          itemBuilder: (context, index) {
            return getContainer(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Tarefa newTarefa = await Navigator.push(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void atualizaTela() {
    api.listaDeTarefas().then((value) {
      setState(() {
        tarefas = value;
        print(value);
      });
    });
  }

  Container getContainer(int index) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(5, 10),
            blurRadius: 50,
            color: Color.fromARGB(50, 0, 0, 0),
          )
        ],
      ),
      child: ListTile(
        title: Text(
          tarefas[index].titulo!,
          style: const TextStyle(
            color: Color(0xff414C64),
          ),
        ),
        subtitle: Text(
          tarefas[index].dataTarefa!,
          style: const TextStyle(
            color: Color(0xff414C64),
          ),
        ),
        leading: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/confirm-circle_normal.png"),
        ),
      ),
    );
  }
}
