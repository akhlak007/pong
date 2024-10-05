import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/brick.dart';
import 'package:pong_game/coverscreen.dart';
import 'package:pong_game/scorescreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomepageState extends State<Homepage> {
  double playerX = -0.2;
  double brickWidth = 0.4;
  int playerScore = 0;
  int enemyScore = 0;
  double enemyX = -0.2;
  double ballX = 0;
  double ballY = 0;

  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT; // Initialize ballXDirection
  bool gameStarted = false;

  void starGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 16), (timer) { // Adjusted timer interval
      updateDirection();
      moveBall();
      moveEnemy();
      if (isPlayerDeath()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }
      if (isEnemyDeath()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
  }

  bool isEnemyDeath() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }



  void _showDialog(bool enemyDead) {
    // ... (Your existing dialog code)
  }

  void resetGame() {
    // ... (Your existing resetGame code)
  }

  bool isPlayerDeath() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  // ... (Your existing code)

  void updateDirection() {
    setState(() {
      // Ball hits player's brick
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
        ballXDirection = (ballX - playerX) > (brickWidth / 2) ? direction.RIGHT : direction.LEFT;
      }
      // Ball hits enemy's brick
      else if (ballY <= -0.9 && enemyX + brickWidth >= ballX && enemyX <= ballX) {
        ballYDirection = direction.DOWN;
        ballXDirection = (ballX - enemyX) > (brickWidth / 2) ? direction.RIGHT : direction.LEFT;
      }
      // Ball hits side walls
      if (ballX >=1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveEnemy() {
    setState(() {
      // Gradually move enemy towards the ball
      if (enemyX + brickWidth / 2 < ballX) {
        enemyX += 0.02; // Adjust speed as needed
      } else if (enemyX + brickWidth / 2 > ballX) {
        enemyX -= 0.02; // Adjust speed as needed
      }
    });
  }

// ... (Rest of your code)

  void moveBall() {
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY+= 0.01;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.01;
      }
      if (ballXDirection == direction.LEFT) { // Corrected movement logic
        ballX -= 0.01;
      } else if (ballXDirection == direction.RIGHT) { // Corrected movement logic
        ballX += 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: starGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: SizedBox( // Added SizedBox for Stack
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Coverscreen(
                    gameStarted: gameStarted,
                  ),
                  Scorescreen(
                    gameStarted: gameStarted,
                    enemyScore: enemyScore,
                    playerScore: playerScore,
                  ),
                  MyBrick(
                    x: enemyX,
                    y: -0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: true,
                  ),
                  MyBrick(
                    x: playerX,
                    y: 0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: false,
                  ),
                  MyBall(x: ballX,
                    y: ballY,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}