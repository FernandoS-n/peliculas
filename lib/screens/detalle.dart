import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

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
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 10),
          _posterTitulo(context, pelicula),
          _descripcion(pelicula),
          _descripcion(pelicula),
          _crearCasting(pelicula)
        ]))
      ],
    ));
  }

  _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.jpeg'),
          image: NetworkImage(pelicula.getPosterimg()),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(pelicula.getPosterimg()),
                  height: 150,
                )),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _descripcion(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  _crearCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return FutureBuilder(
        future: peliProvider.getCast(pelicula.id.toString()),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _crearActoresPageView(snapshot.data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _crearActoresPageView(List? actores) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
        itemCount: actores!.length,
      ),
    );
  }

  _actorTarjeta(actor) {
    return Container(
        child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            placeholder: const AssetImage('assets/img/no-image.png'),
            image: NetworkImage(actor.getFoto()),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(actor.name, overflow: TextOverflow.ellipsis)
      ],
    ));
  }
}
