import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.peliculas});
  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.png'),
              image: NetworkImage(peliculas[index].getPosterimg()),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
