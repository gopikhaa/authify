import 'package:flutter/material.dart';
import '../utils/animations/loginpage_animation.dart';

class AnimatedHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedHomePageState();
  }
}

class _AnimatedHomePageState extends State<AnimatedHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(milliseconds: 400),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomePage(_controller);
  }
}

class _HomePage extends StatelessWidget {
  late final double _deviceHeight;
  late final double _deviceWidth;

  final Color _primarycolor = Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController _controller;
  late final EnterAnimation _animation;

  _HomePage(this._controller)
      : _animation = EnterAnimation(_controller);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
              _nameWidget(),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginAvatar() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(animation: _animation.circleSize, builder: (BuildContext _context,Widget? _widget ){
     return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
            _animation.circleSize.value, _animation.circleSize.value, 1),
      child: Container(
        height: _circleD,
        width: _circleD,
        decoration: BoxDecoration(
          color: _primarycolor,
          borderRadius: BorderRadius.circular(500),
          image: DecorationImage(
            image: AssetImage('assets/images/main_avatar.png'),
          ),
        ),
      ),
    );
    });

    
  }

  Widget _nameWidget() {
    return Text(
      "John Doe",
      style: TextStyle(
        color: _primarycolor, 
        fontSize: 35, 
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _logoutButton(BuildContext _context) {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        "LOG OUT",
        style: TextStyle(
          fontSize: 16, 
          color: _primarycolor, 
          fontWeight: FontWeight.bold,
        ),
      ),
      height: _deviceHeight * 0.05,
      minWidth: _deviceWidth * 0.38,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: _primarycolor, width: 3),
      ),
    );
  }
}
