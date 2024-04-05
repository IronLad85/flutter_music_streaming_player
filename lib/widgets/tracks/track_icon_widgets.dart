import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/utils/theme_data.dart';

class ActionIcon extends StatelessWidget {
  final Color color;
  final double radius;
  final IconData icon;
  final double iconSize;

  const ActionIcon({
    super.key,
    required this.color,
    required this.radius,
    required this.icon,
    this.iconSize = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      ),
    );
  }
}

class PlayIcon extends StatelessWidget {
  final Color color;
  const PlayIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    const double radius = 50;
    return ActionIcon(
      color: color,
      radius: radius,
      icon: Icons.play_arrow,
    );
  }
}

class PauseIcon extends StatelessWidget {
  final Color color;
  const PauseIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    const double radius = 50;
    return ActionIcon(
      color: color,
      radius: radius,
      icon: Icons.pause,
    );
  }
}

class ShowIcon extends StatelessWidget {
  final Color color;
  const ShowIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    const double radius = 32;

    return ActionIcon(
      color: color,
      radius: radius,
      iconSize: 22.0,
      icon: Icons.keyboard_arrow_up,
    );
  }
}

class HideIcon extends StatelessWidget {
  final Color color;
  const HideIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    const double radius = 32;

    return ActionIcon(
      color: color,
      radius: radius,
      iconSize: 22.0,
      icon: Icons.keyboard_arrow_down,
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final double size;

  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    if (isFavorite) {
      return Icon(
        CupertinoIcons.suit_heart_fill,
        size: size,
        color: Colors.red,
      );
    }

    return Icon(
      CupertinoIcons.suit_heart,
      size: 28,
      color: context.theme.lightTextColor,
    );
  }
}
