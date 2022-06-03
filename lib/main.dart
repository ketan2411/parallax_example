import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ParallaxExample(),
    );
  }
}

/// A Calculator.
class ParallaxExample extends StatefulWidget {
  const ParallaxExample({Key? key}) : super(key: key);

  @override
  State<ParallaxExample> createState() => _ParallaxState();
}

class _ParallaxState extends State<ParallaxExample>
    with TickerProviderStateMixin {
  PointerHoverEvent _pointerHoverEvent = const PointerHoverEvent();
  // bool _rotate = false;
  double x = 0;
  double y = 0;
  double _moonRise = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        // color: _animation.transform(t),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 148, 132, 209),
              Color.fromARGB(255, 47, 61, 141),
            ]),
      ),
      child: MouseRegion(
        onEnter: (event) => developer.log(event.toStringFull()),
        onExit: (event) => developer.log(event.toStringFull()),
        onHover: (event) {
          setState(() {
            _pointerHoverEvent = event;
            x = x + _pointerHoverEvent.localDelta.dy;
            y = y + _pointerHoverEvent.localDelta.dx;
            // developer.log((x / 100).toString());
            _moonRise = _pointerHoverEvent.localPosition.dy / 400;

            if (_moonRise < 0.05) {
              _moonRise = 0;
            } else if (_moonRise > 0.95) {
              _moonRise = 1;
            }
            developer.log(_moonRise.toString());
            // log(y.toString());
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Opacity(
              opacity: _moonRise,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 154, 176, 241),
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 246, 209, 202),
                        Color.fromARGB(255, 255, 84, 84),
                      ]),
                ),
              ),
            ),
            Positioned(
              top: _moonRise == 0
                  ? 40
                  : _moonRise == 1
                      ? 400
                      : 400 * _moonRise,
              left: size.width / 2 + y * 0.005 - 50,
              child: Image.asset('/moon.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              top: 10,
              left: -size.width / 2 + y * 0.007 - 50,
              child: Image.asset('/star.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: -10,
              left: -size.width / 2 + y * 0.1 - 50,
              child: Image.asset('/mountain.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: size.height * 0.1,
              left: -size.width / 2 + y * 0.5 + 100,
              child: Image.asset('/tree.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              top: size.height / 2 - 100 * _moonRise,
              left: -size.width / 2 + y * 0.3 + 50 * _moonRise,
              child: Image.asset('/birds.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: -30,
              left: -size.width / 2 + y * 0.8 - 600,
              child: Image.asset('/grass.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: -10,
              left: -size.width / 2 + y * 1 - 50,
              child: Image.asset('/lake.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: 10,
              left: size.width / 2 + y * 1.5 - 50,
              child: Image.asset('/stone.png'),
              //  duration: Duration.zero
            ),

            // Align(
            //   alignment: Alignment(y * 0.001, x * 0.002),
            //   // top: size.height / 2 + x * 0.5 - 100,
            //   // left: size.width / 2 + y * 0.5 - 100,
            //   child: Transform(
            //     transform: Matrix4.identity()
            //       ..setEntry(3, 2, 0.001)
            //       ..rotateX(x / 1000)
            //       ..rotateY(-y / 1000),
            //     alignment: FractionalOffset.center,
            //     child: Container(
            //       height: 150,
            //       width: 150,
            //       color: Colors.blue.withOpacity(1),
            //     ),
            //   ),
            //   //  duration: Duration.zero
            // ),
          ],
        ),
      ),
    );
  }
}
