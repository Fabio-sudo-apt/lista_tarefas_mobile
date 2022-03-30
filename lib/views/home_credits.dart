import 'package:flutter/material.dart';
import 'package:taredas_api/views/util/appBar.dart';

class HomeCredits extends StatelessWidget {
  const HomeCredits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("Creditos"),
        backgroundColor: const Color(0xff1CB273),
        body: const Center(
          child: Text(
            "Devs: Silas e Fábio",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20.0,
              backgroundColor: Colors.white
            ),
          ),
        ));
  }
}
