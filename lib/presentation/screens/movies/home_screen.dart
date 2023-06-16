import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';



///el go outer me dice cual es la vista que se quiere mostar, se cambia pero no se destruye ni se re dibuja
class HomeScreen extends StatelessWidget {
  //me tienen que enviar un widget
  static const name = 'home-screen';
  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      //barra de navegacion inferior
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
