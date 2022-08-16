import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool isTurnHappy = true;

  List<String> XorOlist = ['', '', '', '', '', '', '', '', ''];

  int filledBoxes = 0;

  bool gameHasResult = false;

  int score1 = 0;
  int score2 = 0;

  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                clearGame();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Tic  Tac  Toe ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              getScoreBoard(),
              SizedBox(height: 19),
              getResultButton(),
              SizedBox(height: 18),
              getGridView(),
              getTurn(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                tapped(index);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    XorOlist[index],
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: XorOlist[index] == ':)'
                            ? Colors.purple
                            : Colors.yellow),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (isTurnHappy && XorOlist[index] == '') {
        XorOlist[index] = ':)';
        isTurnHappy = !isTurnHappy;
        filledBoxes = filledBoxes + 1;
      }
      if (!isTurnHappy && XorOlist[index] == '') {
        XorOlist[index] = ':(';
        isTurnHappy = !isTurnHappy;
        filledBoxes = filledBoxes + 1;
      }

      checkWinner();
    });
  }

  void checkWinner() {
    if (XorOlist[0] == XorOlist[1] &&
        XorOlist[0] == XorOlist[2] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'winner is ' + XorOlist[0]);
      return;
    }

    if (XorOlist[3] == XorOlist[4] &&
        XorOlist[3] == XorOlist[5] &&
        XorOlist[3] != '') {
      setResult(XorOlist[3], 'winner is ' + XorOlist[3]);
      return;
    }

    if (XorOlist[6] == XorOlist[7] &&
        XorOlist[6] == XorOlist[8] &&
        XorOlist[6] != '') {
      setResult(XorOlist[6], 'winner is ' + XorOlist[6]);
      return;
    }

    if (XorOlist[0] == XorOlist[3] &&
        XorOlist[0] == XorOlist[6] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'winner is ' + XorOlist[0]);
      return;
    }

    if (XorOlist[1] == XorOlist[4] &&
        XorOlist[1] == XorOlist[7] &&
        XorOlist[1] != '') {
      setResult(XorOlist[1], 'winner is ' + XorOlist[1]);
      return;
    }

    if (XorOlist[2] == XorOlist[5] &&
        XorOlist[2] == XorOlist[8] &&
        XorOlist[2] != '') {
      setResult(XorOlist[2], 'winner is ' + XorOlist[2]);
      return;
    }

    if (XorOlist[0] == XorOlist[4] &&
        XorOlist[0] == XorOlist[8] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'winner is ' + XorOlist[0]);
      return;
    }

    if (XorOlist[2] == XorOlist[4] &&
        XorOlist[2] == XorOlist[6] &&
        XorOlist[2] != '') {
      setResult(XorOlist[2], 'winner is ' + XorOlist[2]);
      return;
    }

    if (filledBoxes == 9) {
      setResult('', 'game is Draw');
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      winnerTitle = title;
      if (winner == ':)') {
        score1 = score1 + 1;
      } else if (winner == ':(') {
        score2 = score2 + 1;
      } else {
        score1 = score1 + 1;
        score2 = score2 + 1;
      }
      gameHasResult = true;
    });
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color.fromARGB(255, 32, 87, 94), width: 2),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle , play again',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnHappy ? 'Turn Happy' : 'Turn Sad',
      style: TextStyle(
        fontSize: 28,
        color: isTurnHappy ? Colors.purple : Colors.yellow,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Player :)',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.cyan[800],
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Text(
              '$score1',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Player :(',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.cyan[800],
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Text(
              '$score2',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < XorOlist.length; i++) {
        XorOlist[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
