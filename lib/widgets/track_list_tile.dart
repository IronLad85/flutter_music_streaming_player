import 'package:flutter/material.dart';
import 'package:music_player/models/tracks.dart';

class TrackListTile extends StatelessWidget {
  final Track track;

  const TrackListTile({
    super.key,
    required this.track,
  });

  Widget _buildTrackImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.grey.shade300,
          child: Image.network(
            track.albumImage,
            width: 70,
            height: 70,
          ),
        ),
      ),
    );
  }

  Widget _buildTrackInfo() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            track.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            track.artistName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          _buildTrackImage(),
          _buildTrackInfo(),
        ],
      ),
    );
  }
}
