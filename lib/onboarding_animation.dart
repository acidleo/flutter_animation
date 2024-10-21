import 'package:flutter/material.dart';

class ExpandingImagePage extends StatefulWidget {
  @override
  _ExpandingImagePageState createState() => _ExpandingImagePageState();
}

class _ExpandingImagePageState extends State<ExpandingImagePage>
    with TickerProviderStateMixin {
  late AnimationController _basecontroller;
  late Animation<double> _basescaleAnimation;
  late Animation<double> _baseOpacityAnimation;

  late AnimationController _centercontroller;
  late Animation<double> _centerscaleAnimation;
  late Animation<double> _centerOpacityAnimation;

  late AnimationController _topcontroller;
  late Animation<double> _topscaleAnimation;
  late Animation<double> _topOpacityAnimation;

  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  late AnimationController _micController;
  late Animation<double> _micScaleAnimation;

  @override
  void initState() {
    super.initState();

    _basecontroller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _basescaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _basecontroller,
        curve: Curves.easeInOut,
      ),
    );

    _baseOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _basecontroller,
        curve: const Interval(
          0.4,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _centercontroller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _centerscaleAnimation = Tween<double>(begin: 0.25, end: 1.0).animate(
      CurvedAnimation(parent: _centercontroller, curve: Curves.easeInOut),
    );

    _centerOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _centercontroller,
        curve: const Interval(
          0.3,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _topcontroller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _topscaleAnimation = Tween<double>(begin: 0.115, end: 1.0).animate(
      CurvedAnimation(parent: _topcontroller, curve: Curves.easeInOut),
    );

    _topOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _topcontroller,
        curve: const Interval(
          0.2,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut),
    );

    _micController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _micScaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(parent: _micController, curve: Curves.easeInOut),
    );

    _basecontroller.forward();
    _centercontroller.forward();
    _topcontroller.forward();
    _micController.forward();

    _basecontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkIfAllAnimationsComplete();
      }
    });

    _centercontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkIfAllAnimationsComplete();
      }
    });

    _topcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkIfAllAnimationsComplete();
      }
    });
  }

  void _checkIfAllAnimationsComplete() {
    if (_basecontroller.isCompleted &&
        _centercontroller.isCompleted &&
        _topcontroller.isCompleted) {
      _opacityController.forward();
    }
  }

  @override
  void dispose() {
    _basecontroller.dispose();
    _centercontroller.dispose();
    _topcontroller.dispose();
    _opacityController.dispose();
    _micController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _basescaleAnimation,
              child: FadeTransition(
                opacity: _baseOpacityAnimation,
                child: Image.asset(
                  'assets/images/base_eclipse.png',
                ),
              ),
            ),
            ScaleTransition(
              scale: _centerscaleAnimation,
              child: FadeTransition(
                opacity: _centerOpacityAnimation,
                child: Image.asset(
                  'assets/images/center_eclipse.png',
                ),
              ),
            ),
            ScaleTransition(
              scale: _topscaleAnimation,
              child: FadeTransition(
                opacity: _topOpacityAnimation,
                child: Image.asset(
                  'assets/images/top_eclipse.png',
                ),
              ),
            ),
            ScaleTransition(
              scale: _micScaleAnimation,
              child: Image.asset(
                'assets/images/mic.png',
                height: 100,
                width: 100,
              ),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 270,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg1.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 270,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg2.png'),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg3.png'),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg4.png'),
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 30,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg5.png'),
                    ),
                  ),
                  Positioned(
                    top: 210,
                    right: 80,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/faceimg6.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
