import 'package:flutter/material.dart';

class PlayIcon extends StatelessWidget {
  final Color _color;

  const PlayIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 55;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: _color,
          size: 32.0,
        ),
      ),
    );
  }
}

class PauseIcon extends StatelessWidget {
  final Color _color;

  const PauseIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 55;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          Icons.pause,
          color: _color,
          size: 32.0,
        ),
      ),
    );
  }
}

class ShowIcon extends StatelessWidget {
  final Color _color;

  const ShowIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 32;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: _color,
          size: 22.0,
        ),
      ),
    );
  }
}

class HideIcon extends StatelessWidget {
  final Color _color;

  const HideIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 32;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: _color,
          size: 22.0,
        ),
      ),
    );
  }
}
