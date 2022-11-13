import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';


final Random rng = Random();
final ConfettiController controller = ConfettiController(duration: const Duration(seconds: 2));
final List<String> img = [
  "../assets/a1.jpg", "../assets/a2.jpg", "../assets/a3.jpg", "../assets/a4.jpg",
  "../assets/a5.jpg", "../assets/a6.jpg", "../assets/a7.jpg", "../assets/a8.jpg",
  "../assets/a9.jpg", "../assets/a10.jpg", "../assets/a11.jpg", "../assets/a12.jpg",
  "../assets/a13.jpg", "../assets/a14.jpg", "../assets/a15.jpg", "../assets/a16.jpg",
];

List<bool> random(size){
  List<bool> x = List.filled(16, false);

  int cnt = 0;
  while(cnt < 3){
    int i = rng.nextInt(16);
    if(!x[i]) {
      x[i] = true;
      ++cnt;
    }
  }

  return x;
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(home: HomeScreen(title: "Halloween Project"));
  }
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<bool> state = random(16);
  int cnt = 0;

  @override
  Widget build(BuildContext context){
    if(cnt > 10){
      controller.play();

      return Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: Colors.amberAccent,
            appBar: AppBar(
              title: const Text("Boo!"),
            ),
            body: Center(
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: const Image(image: AssetImage("../assets/aa.jpg"))
                )
              )
            ),
          ),
          ConfettiWidget(
              confettiController: controller,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Counter: $cnt",
        textAlign: TextAlign.center)),
      body: Center(
        child: Table(
          children: [
            TableRow(children: [buildImage(0), buildImage(1), buildImage(2), buildImage(3)]),
            TableRow(children: [buildImage(4), buildImage(5), buildImage(6), buildImage(7)]),
            TableRow(children: [buildImage(8), buildImage(9), buildImage(10), buildImage(11)]),
            TableRow(children: [buildImage(12), buildImage(13), buildImage(14), buildImage(15)]),
          ],
          defaultColumnWidth: const FixedColumnWidth(225)
        )
      ),
      backgroundColor: Colors.lightGreenAccent,
    );
  }

  Widget buildImage(int num){
    return GestureDetector(
      onTap: () {
        setState(() {
          if(state[num]) {
            int rand = rng.nextInt(16);
            while (state[rand]) {
              rand = rng.nextInt(16);
            }
            ++cnt;
            state[rand] = true;
            state[num] = false;
          }
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Visibility(
            visible: state[num],
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(image: AssetImage(img[num]), height: 150, fit: BoxFit.fitWidth)
              )
            )
          )
        )
      )
    );
  }
}
