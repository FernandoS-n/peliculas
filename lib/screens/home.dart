// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/utils/search_delegate.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_horizontal.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en Cartelera'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Datasearch());
              },
              icon: Icon(Icons.search_rounded)),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getEncines(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Populares',
            // style: Theme.of(context).textTheme.titleMedium,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas: snapshot.data!,
                siguientePagina: peliculasProvider.getEncines,
                // peliculasProvider.getPopulares,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ]),
    );
  }
}
