import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class Datasearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = PeliculasProvider();

  final peliculas = [];

  final peliculasRecientes = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;

            return ListView(
                children: peliculas!.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterimg()),
                    placeholder: AssetImage('assets/img/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
