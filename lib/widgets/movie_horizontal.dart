import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal(
      {super.key, required this.peliculas, required this.siguientePagina});
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, index) => tarjeta(context, peliculas[index]),
      ),
    );
  }

  tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-movie';
    final tarjeta = Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.png'),
                image: NetworkImage(pelicula.getPosterimg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          )
        ],
      ),
    );
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
        child: tarjeta);
  }
}
