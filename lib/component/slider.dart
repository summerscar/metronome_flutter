import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SliderRow extends StatelessWidget {
  final int bmp;
  final Function setBmpHandler;
  final bool isRunning;
  final Function toggleRunning;
  final AnimationController _animationController;

  SliderRow(this.bmp, this.setBmpHandler, this.isRunning, this.toggleRunning, this._animationController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SleekCircularSlider(
              min: 30,
              max: 200,
              initialValue: this.bmp.toDouble(),
              appearance: CircularSliderAppearance(
                size: 270,
                infoProperties: InfoProperties(
                  modifier: (percentage) => percentage.toInt().toString(),
                ),
                customColors: CustomSliderColors(
                  hideShadow: true,
                  progressBarColors: [Color.fromARGB(255, 62, 164, 255), Color.fromARGB(255, 102, 204, 255), Color.fromARGB(255, 142, 244, 255)]
                )
              ),
              onChange: (double value) {
                setBmpHandler(value.toInt());
            }),
          ],
        ),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _animationController,
          ),
          onPressed: () => toggleRunning(),
          color: Theme.of(context).textTheme.headline3.color,
        )
      ]
    );
  }
}