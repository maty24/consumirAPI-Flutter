import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    //busco el color en el tema global
    final colors = Theme.of(context).colorScheme;
    //el titlemedium es un estilo que esta en el tema global
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    //el safearea es para que no se vea el notch de los iphone
    return SafeArea(
      child: Padding(
          //el edgeinsets es para que el texto no este pegado a los bordes  y symmetric es para que sea igual en los dos lados
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            //el double.infinity es para que el widget ocupe todo el ancho
            width: double.infinity,
            //el row es para que el icono y el texto esten en la misma linea
            child: Row(children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              //el spacer es para que el icono se ponga al final y el texto se ponga al principio, pega todo al final
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ]),
          )),
    );
  }
}
