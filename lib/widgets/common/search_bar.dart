import 'package:flutter/cupertino.dart';
import 'package:music_player/utils/theme_data.dart';

class TrackSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  const TrackSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 10),
      child: CupertinoSearchTextField(
        key: const Key('search-field'),
        autofocus: false,
        onChanged: onSearch,
        onSubmitted: onSearch,
        style: TextStyle(color: context.theme.mediumTextColor),
      ),
    );
  }
}
