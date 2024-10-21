import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math'; // For using pi

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _imageZoomAnimation;
  late Animation<double> _imageOpacityAnimation;
  late Animation<double> _containerPositionAnimation;
  late Animation<double> _containerOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    // Gradient animation
    _animation = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Image zoom-out animation
    _imageZoomAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _imageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    // Ellipse Gradient
    _containerPositionAnimation = Tween<double>(begin: 0.8, end: 0.34).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
      ),
    );
    _containerOpacityAnimation = Tween<double>(begin: 0.0, end: 0.20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
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
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: Colors.black,
              ),

              // Background gradient
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height * _animation.value,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7C22B3),
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),

              // Ellipse gradient animation
              Positioned(
                top: MediaQuery.of(context).size.height *
                    _containerPositionAnimation.value,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: AnimatedOpacity(
                  opacity: _containerOpacityAnimation.value,
                  duration: Duration(milliseconds: 1000),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: ClipOval(
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-2, 0),
                            end: Alignment(0.5, 0),
                            colors: [
                              Color(0xFFF8A1FD),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // App icon animation
              Positioned(
                top: MediaQuery.of(context).size.height * 0.445,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.28,
                child: AnimatedOpacity(
                  opacity: _imageOpacityAnimation.value,
                  duration: Duration(milliseconds: 500),
                  child: Transform.scale(
                    scale: _imageZoomAnimation.value,
                    child: SvgPicture.asset(
                      'assets/images/appIcon.svg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),

              // Extra icons
              _buildJumpingIcon(
                context,
                'assets/images/triicon.svg',
                topStart: 0.5,
                leftStart: 0.5,
                topEnd: 0.455,
                leftEnd: 0.52,
                iconSize: 21,
                startAt: 0.9,
              ),
              _buildJumpingIcon(
                context,
                'assets/images/rocketicon.svg',
                topStart: 0.5,
                leftStart: 0.5,
                topEnd: 0.53,
                leftEnd: 0.70,
                iconSize: 15,
                startAt: 0.9,
              ),
              _buildJumpingIcon(
                context,
                'assets/images/fanicon.svg',
                topStart: 0.5,
                leftStart: 0.5,
                topEnd: 0.49,
                leftEnd: 0.23,
                iconSize: 50,
                startAt: 0.9,
              ),
              _buildJumpingIcon(
                context,
                'assets/images/candyicon.svg',
                topStart: 0.5,
                leftStart: 0.5,
                topEnd: 0.59,
                leftEnd: 0.6,
                iconSize: 25,
                startAt: 0.9,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildJumpingIcon(
    BuildContext context,
    String assetPath, {
    required double topStart,
    required double leftStart,
    required double topEnd,
    required double leftEnd,
    required double iconSize,
    required double startAt,
  }) {
    return Positioned(
      top: MediaQuery.of(context).size.height *
          Tween<double>(begin: topStart, end: topEnd)
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(startAt, 1.0, curve: Curves.easeOut),
                ),
              )
              .value,
      left: MediaQuery.of(context).size.width *
          Tween<double>(begin: leftStart, end: leftEnd)
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(startAt, 1.0, curve: Curves.easeOut),
                ),
              )
              .value,
      child: AnimatedOpacity(
        opacity: _controller.value >= startAt ? 1 : 0.0,
        duration: Duration(milliseconds: 1250),
        child: Transform.scale(
          scale: Tween<double>(begin: 0.5, end: 1.0)
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(startAt, 1.0, curve: Curves.easeIn),
                ),
              )
              .value,
          child: SvgPicture.asset(
            assetPath,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}
