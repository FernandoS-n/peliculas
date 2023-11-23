import 'package:flutter/material.dart';
import 'package:peliculas/screens/detalle.dart';
import 'package:peliculas/screens/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
        'detalle': (context) => PeliculaDetalle()
      },
    );
  }
}
