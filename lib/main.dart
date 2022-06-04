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
  bool _isMobile = false;
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
    if (size.width < 800) {
      _isMobile = true;
    }
    return MouseRegion(
      onEnter: (event) => developer.log(event.toStringFull()),
      onExit: (event) => developer.log(event.toStringFull()),
      onHover: (event) {
        setState(() {
          _pointerHoverEvent = event;
          x = x + _pointerHoverEvent.localDelta.dy;
          y = y + _pointerHoverEvent.localDelta.dx;
          _moonRise =
              (_pointerHoverEvent.localPosition.dx * 100 / size.width) / 100;

          developer.log(_moonRise.toString());
        });
      },
      child: GestureDetector(
        onPanUpdate: ((details) {
          setState(() {
            x = details.localPosition.dy;
            y = details.localPosition.dx;
            // _moonRise =
            //     (_pointerHoverEvent.localPosition.dx * 100 / size.width) / 100;
            // developer.log(_moonRise.toString());

            developer.log(
                '${details.globalPosition.dx},${details.globalPosition.dy}---${details.localPosition.dx},${details.localPosition.dy} || ${details.delta.dx},${details.delta.dy}');
          });
        }),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Opacity(
              opacity: 1,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0,
                        0.15,
                        0.4
                      ],
                      colors: [
                        Color(0xff57B4A0),
                        Color(0xffB7D9B6),
                        Color(0xffE9F2E6),
                      ]),
                ),
              ),
            ),
            Positioned(
              // top: -180,
              top: _moonRise == 0
                  ? -210
                  : _moonRise == 1
                      ? -180
                      : -180 + 30 * _moonRise,
              // left: size.width / 2 + y * 0.005 - 50,
              child: Image.asset('/sun.png'),
              //  duration: Duration.zero
            ),

            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              // top: 10,
              left: -size.width / 2 + y * 0.03 - 50,
              child: Image.asset('/4.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: -100,
              left: -size.width / 2 + y * 0.07 - 50,
              child: Image.asset('/3.png'),
              //  duration: Duration.zero
            ),

            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              // top: size.height / 2 - 100 * _moonRise,
              // bottom: 20,
              left: -size.width / 2 + y * 0.3 + 50,
              child: Image.asset('/2.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              // top: size.height / 2 + x * 0.1 - 50,
              bottom: 0,
              // left: ,
              left: _isMobile ? y - 700 : -size.width / 1 + y * 1,
              child: Image.asset('/1.png'),
              //  duration: Duration.zero
            ),
            Positioned(
              top: -100,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset('/glow.png'),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Image.asset(
                '/attribute.png',
                height: 15,
              ),
            )

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
