import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/services/favorite_service.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/track_icon_widgets.dart';
import 'package:provider/provider.dart';

class TrackFavoriteButton extends StatefulWidget {
  final Track track;
  const TrackFavoriteButton({super.key, required this.track});

  @override
  State<TrackFavoriteButton> createState() => _TrackFavoriteButtonState();
}

class _TrackFavoriteButtonState extends State<TrackFavoriteButton> {
  late MainStore mainStore;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
  }

  void onFavoriteToggle(bool canMarkAsFavorite) {
    HapticFeedback.heavyImpact();
    if (canMarkAsFavorite) {
      FavoritesService.instance.setAsFavorite(widget.track);
    } else {
      FavoritesService.instance.removeAsFavorite(widget.track);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isFavorite = mainStore.tracksStore.isFavoriteTrack(widget.track.id);

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onFavoriteToggle(!isFavorite),
        child: Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            bottom: 5,
            right: 15,
          ),
          child: FavoriteIcon(isFavorite: isFavorite),
        ),
      );
    });
  }
}
