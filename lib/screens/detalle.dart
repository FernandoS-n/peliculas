import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(pelicula),
          SliverList(delegate: SliverChildListDelegate([]))
        ],
      ),
    );
  }

  _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black87,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        background: FadeInImage(
          placeholder: AssetImage(
            'assets\img\loading.jpeg',
          ),
          image: NetworkImage(pelicula.getPosterimg()),
          fadeInDuration: Duration(microseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
