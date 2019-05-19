import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //TODO: Link up images
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage edit = AssetImage("images/edit.png");
  AssetImage circle = AssetImage("images/circle.png");

  bool isCross = true;
  bool isWin = false;
  String message;
  String message_final;
  List<String> gameState;
  int crossWins;
  int circleWins;

  // TODO: initiaize the state of the box with empty;
  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
      this.message_final = "";
      this.isWin = false;
      crossWins = circleWins = 0;
    });
  }

  void resetScore() {
    setState(() {
      crossWins = 0;
      circleWins = 0;
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
      this.message_final = "";
      this.isWin = false;
    });
  }

  // TODO: playgame Method
  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = 'cross';
        } else {
          this.gameState[index] = 'circle';
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  // TODO: Reset Game Method
  resetGame() {
    setState(() {
      this.isWin = false;
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
      this.message_final = "";
    });
  }

  // TODO: Get Image Method
  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('circle'):
        return circle;
        break;
      case ('cross'):
        return cross;
        break;
    }
  }

  // TODO: Winning logic
  checkWin() async {
    if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if ((gameState[3] != "empty") &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = "${this.gameState[3]} Wins";
      });
    } else if ((gameState[6] != "empty") &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = "${this.gameState[6]} Wins";
      });
    } else if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = "${this.gameState[0]} Wins";
      });
    } else if ((gameState[1] != "empty") &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = "${this.gameState[1]} Wins";
      });
    } else if ((gameState[2] != "empty") &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = "${this.gameState[2]} Wins";
      });
    } else if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = "${this.gameState[0]} Wins";
      });
    } else if ((gameState[2] != "empty") &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = "${this.gameState[2]} Wins";
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
      });
    }
    if (this.message == "circle Wins") {
      setState(() {
        circleWins++;
      });
    } else if (this.message == "cross Wins") {
      setState(() {
        crossWins++;
      });
    } else {
      print("H");
    }
    if (this.message == "circle Wins" ||
        this.message == "cross Wins" ||
        this.message == "Game Draw") {
      message_final = "GAME RESETS IN 5 SECS";
      isWin = true;
      await Future.delayed(Duration(seconds: 5));
      resetGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: MaterialButton(
                        onPressed: () {
                          resetScore();
                        },
                        child: Text("Reset Scores")),
                  ),
                ],
          )
        ],
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => AbsorbPointer(
                    absorbing: this.isWin,
                    child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: MaterialButton(
                          color: Color(0xFFdcdde1),
                          onPressed: () {
                            playGame(i);
                          },
                          child: Image(
                            image: this.getImage(this.gameState[i]),
                          ),
                        )),
                  ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(this.message.toUpperCase() + "\n" + this.message_final,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          MaterialButton(
            elevation: 20.0,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            color: Color(0xFFc23616),
            onPressed: () {
              this.resetGame();
            },
            minWidth: 300.0,
            height: 50.0,
            child: Text(
              "Reset Game",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cross Wins:\n" + this.crossWins.toString(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                color: Colors.red,
              ),
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Circle Wins:\n" + this.circleWins.toString(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
