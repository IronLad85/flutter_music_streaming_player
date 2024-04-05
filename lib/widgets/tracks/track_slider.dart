import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/store/main_store.dart';
import 'package:provider/provider.dart';

class TrackSlider extends StatelessWidget {
  const TrackSlider({super.key});

  @override
  Widget build(BuildContext context) {
    MainStore mainStore = Provider.of<MainStore>(context);

    return Observer(
      builder: (_) {
        Duration trackDuration = mainStore.audioPlayerStore.duration;
        Duration seekValue = mainStore.audioPlayerStore.seekValue;

        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
          ),
          child: Builder(builder: (context) {
            if (trackDuration.inSeconds <= 0) {
              return Slider(
                value: 0,
                onChanged: (double value) {},
                activeColor: Colors.white38,
                inactiveColor: Colors.white12,
              );
            }

            return Slider(
              min: 0,
              max: trackDuration.inMilliseconds.toDouble(),
              value: seekValue.inMilliseconds.toDouble(),
              onChangeStart: (double value) {
                mainStore.audioPlayerStore.setSeekValue(
                  Duration(milliseconds: value.toInt()),
                  isSeekingValue: true,
                );
              },
              onChanged: (double value) {
                mainStore.audioPlayerStore.setSeekValue(
                  Duration(milliseconds: value.toInt()),
                  isSeekingValue: true,
                );
              },
              onChangeEnd: (double value) async {
                await mainStore.audioPlayerStore.seek(
                  Duration(milliseconds: value.toInt()),
                );

                mainStore.audioPlayerStore.setSeekValue(
                  Duration(milliseconds: value.toInt()),
                  isSeekingValue: false,
                );
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white38,
            );
          }),
        );
      },
    );
  }
}
