import 'package:flutter/material.dart';

class EmptyAlbumArtContainer extends StatelessWidget {
  const EmptyAlbumArtContainer({
    super.key,
    required this.radius,
    required this.iconSize,
  });

  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        padding:
            const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    color: Colors.grey[400],
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        size: iconSize,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Opacity(
                opacity: 0.55,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [
                          0.0,
                          0.85,
                        ],
                        colors: [
                          Color(0xFF47ACE1),
                          Color(0xFFDF5F9D),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
