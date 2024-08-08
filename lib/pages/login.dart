import 'package:flutter/material.dart';
import '../utils/animations/loginpage_animation.dart';
import './homepage.dart';
import '../utils/animations/page_route/fade_page.dart';

class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({super.key});

  @override
  State<AnimatedLoginPage> createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late EnterAnimation _enterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 400),
    );

    _enterAnimation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(controller: _controller, animation: _enterAnimation);
  }
}

class _LoginPage extends StatelessWidget {
  final AnimationController controller;
  final EnterAnimation animation;

  _LoginPage({required this.controller, required this.animation}) {
    controller.forward();
  }

  final Color _primarycolor = Color.fromRGBO(125, 191, 211, 1.0);
  final Color _secondaryColor = Color.fromRGBO(169, 224, 241, 1.0);
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _primarycolor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: _deviceHeight * 0.60,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _loginAvatar(),
              SizedBox(height: _deviceHeight * 0.05),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(height: _deviceHeight * 0.10),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginAvatar() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (BuildContext _context, Widget? _widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
              animation.circleSize.value, animation.circleSize.value, 1),
          child: Container(
            height: _circleD,
            width: _circleD,
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                image: AssetImage('assets/images/main_avatar.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emailTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: const TextField(
        style: TextStyle(color: Colors.white),
        autocorrect: false,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "john.joe@gmail.com",
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: const TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white),
        autocorrect: false,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext _context) {
    return MaterialButton(
      onPressed: () async {
        await controller.reverse();
        Navigator.pushReplacement(_context, FadePageRoute(AnimatedHomePage()));
      },
      child: Text(
        "LOG IN",
        style: TextStyle(
            fontSize: 16, color: _primarycolor, fontWeight: FontWeight.bold),
      ),
      height: _deviceHeight * 0.05,
      minWidth: _deviceWidth * 0.38,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
  }
}
