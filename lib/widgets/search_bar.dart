import 'package:flutter/cupertino.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:provider/provider.dart';

class TrackSearchBar extends StatefulWidget {
  const TrackSearchBar({super.key});

  @override
  State<TrackSearchBar> createState() => _TrackSearchBarState();
}

class _TrackSearchBarState extends State<TrackSearchBar> {
  late MainStore mainStore;
  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 10),
      child: CupertinoSearchTextField(
        style: TextStyle(
          color: context.theme.mediumTextColor,
        ),
        onChanged: mainStore.tracksStore.setSearchTerm,
        onSubmitted: mainStore.tracksStore.setSearchTerm,
      ),
    );
  }
}
