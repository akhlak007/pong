import 'package:flutter/material.dart';
class Coverscreen extends StatelessWidget {
  final bool gameStarted;
  Coverscreen({required this.gameStarted});



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0,-0.2),
      child: Text(
        gameStarted ? '' : "T A P T O P L A Y",style: TextStyle(color: Colors.white),),
    );
  }
}
