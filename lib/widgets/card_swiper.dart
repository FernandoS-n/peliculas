import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.peliculas});
  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Swiper(
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.5,
        itemBuilder: (context, index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-swiper';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]);
                },
                child: FadeInImage(
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: NetworkImage(peliculas[index].getPosterimg()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
