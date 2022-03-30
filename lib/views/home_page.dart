import 'package:flutter/material.dart';
import 'package:taredas_api/model/config_db.dart';
import 'package:taredas_api/views/home_credits.dart';
import 'package:taredas_api/views/home_video.dart';
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
        tarefas.sort((a, b) => a.dataTarefa!.contains(b.dataTarefa!) ? 1 : -1);
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        //color: Theme.of(context).colorScheme.primary,
        child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.primary),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const HomeCredits()),
                          ),
                        );
                      },
                      icon: const Icon(Icons.group)),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const HomeVideo()),
                        ),
                      );
                    },
                    icon: const Icon(Icons.video_call),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
