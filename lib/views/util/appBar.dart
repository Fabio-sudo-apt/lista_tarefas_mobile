import 'package:flutter/material.dart';

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
