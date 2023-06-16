import 'package:cinemapedia/presentation/view/movies/favories_view.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../view/movies/home_view.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRouters = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // el index es para saber en que pagina estoy
      body: IndexedStack(
        //el index es para saber en que pagina estoy
        index: pageIndex,
        //el children son los widgets que se van a mostrar y depende del index
        children: viewRouters,
      ),
      //barra de navegacion inferior
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
