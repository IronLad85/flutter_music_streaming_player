import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/track/favorite_tracks_list.dart';
import 'package:music_player/screens/track/tracks_list.dart';
import 'package:music_player/screens/profile/user_profile_page.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/common/search_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onProfileTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return const UserProfilePage();
        },
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15, left: 25, right: 20),
      child: Row(
        children: [
          Text(
            'Music list',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'SanFransico',
              fontWeight: FontWeight.w700,
              color: context.theme.mediumTextColor,
            ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () => _onProfileTap(context),
            child: Icon(
              CupertinoIcons.profile_circled,
              size: 40,
              color: Colors.grey.shade600,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    var mainStore = Provider.of<MainStore>(context, listen: false);
    return TrackSearchBar(onSearch: mainStore.tracksStore.setSearchTerm);
  }

  Widget _buildTabBar(BuildContext context) {
    TextStyle style = TextStyle(
      color: context.theme.mediumTextColor,
      fontFamily: 'SanFransico',
      fontSize: 18,
      letterSpacing: 1.4,
    );

    return TabBar(
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(child: Text('Tracks', style: style)),
        Tab(child: Text('Favorites', style: style)),
      ],
    );
  }

  Widget _buildTabContent() {
    return const Expanded(
      child: TabBarView(
        children: [
          TracksList(),
          FavoriteTracksList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.theme.pageBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeaderBar(context),
              _buildTabBar(context),
              _buildSearchBar(context),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }
}
