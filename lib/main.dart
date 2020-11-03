import 'package:flutter/material.dart';
import './component/slider.dart';
import './component/indactor.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _bmp = 70;
  int _nowStep = 0;
  bool _isRunning = false;
  Timer timer;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  AnimationController _animationController;

  void _setBmpHanlder(int val) {
    setState(() {
      _bmp = val;
    });
  }
  void _toggleIsRunning () {
    if (_isRunning) {
      timer.cancel();
      _animationController.reverse();
    } else {
      runTimer();
      _animationController.forward();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }
  void _setNowStep() {
    setState(() {
      _nowStep++;
    });
  }

  void _playAudio () {
    if (_nowStep % 4 == 0) {
      assetsAudioPlayer.open(Audio('assets/metronome1.mp3'));
    } else {
      assetsAudioPlayer.open(Audio('assets/metronome2.mp3'));
    }
  }

  void runTimer () {
    timer = Timer(Duration(milliseconds: (60 / _bmp * 1000).toInt()), () {
      _setNowStep();
      _playAudio();
      runTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    // runTimer();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '节拍器',
              style: Theme.of(context).textTheme.headline3,
            ),
            SliderRow(_bmp, _setBmpHanlder, _isRunning, _toggleIsRunning, _animationController),
            IndactorRow(_nowStep)
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
