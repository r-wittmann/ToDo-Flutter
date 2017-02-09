import 'package:flutter/material.dart';

class ToDoSplash extends StatefulWidget {
  @override
  State createState() => new ToDoSplashState();
}

class ToDoSplashState extends State<ToDoSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationLogo;
  Animation<double> _animationText;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..forward();

    _animationLogo = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.4, curve: Curves.bounceOut),
    );
    _animationText = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.3, 0.5, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _getSplash(BuildContext context, Widget chilc) {
    return new Container(
      decoration: new BoxDecoration(
        backgroundColor: new Color.fromRGBO(26, 28, 26, 1.0),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Transform(
            transform: new Matrix4.translationValues(
                0.0, -50.0 + (1 - _animationLogo.value) * -300, 0.0),
            child: new Image.asset('assets/logo_light.png'),
          ),
          new Transform(
            transform: new Matrix4.translationValues(
                (1 - _animationText.value) * 400, 30.0, 0.0),
            child: new Image.asset('assets/text.png'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _animationLogo,
      builder: _getSplash,
    );
  }
}
