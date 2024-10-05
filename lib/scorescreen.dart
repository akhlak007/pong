import 'package:flutter/material.dart';
class Scorescreen extends StatelessWidget {
  final bool gameStarted;
  final enemyScore;
  final playerScore;

   Scorescreen({super.key, required this.gameStarted,this.enemyScore,this.playerScore});

  @override
  Widget build(BuildContext context) {
    return gameStarted? Stack(
      children: [
        Container(
          alignment: Alignment(0,0),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width/4,
            color: Colors.grey[800],
          ),
        ),
        Container(
          alignment: Alignment(0,-0.3),
          child: Text(enemyScore.toString(),style: TextStyle(color: Colors.grey[700],fontSize: 100),),
        ),
        Container(
          alignment: Alignment(0,0.3),
          child: Text(playerScore.toString(),style: TextStyle(color: Colors.grey[700],fontSize: 100),),
        ),
      ]
    ): Container();
  }
}
