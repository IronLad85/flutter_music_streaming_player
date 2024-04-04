import 'dart:async';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/screens/home_layout/tracks_list.dart';
import 'package:music_player/screens/track_details/track_details_page.dart';
import 'package:music_player/services/music_service.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/bottom_panel.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin, RouteAware, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  late MainStore mainStore;
  TabController? tabController;
  bool showingIncomingRequestPopup = false;
  final PanelController _panelController = PanelController();

  List<Widget> tabBarScreens = [
    const TracksList(),
    Container(child: const SafeArea(child: Text('TAB 2'))),
    Container(child: const SafeArea(child: Text('TAB 3'))),
  ];

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    initMainStoreToServices(mainStore);
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    handleAppLifeCycleChange(state);
  }

  void initMainStoreToServices(MainStore mainStore) {
    MusicService.instance.setMainStoreReference(mainStore);
  }

  Future<void> handleAppLifeCycleChange(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {}
  }

  Widget panelCollapsedView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.7],
          colors: [Color(0xFF47ACE1), Color(0xFFDF5F9D)],
        ),
      ),
      child: BottomPanel(controller: _panelController),
    );
  }

  Widget panelOpenedView() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: NowPlayingScreen(controller: _panelController),
    );
  }

  Widget _buildPageBody() {
    return Observer(builder: (context) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;

      return SlidingUpPanel(
        minHeight: track != null ? 115 : 0,
        renderPanelSheet: true,
        panelSnapping: true,
        controller: _panelController,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        panelBuilder: panelOpenedView,
        collapsed: panelCollapsedView(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: tabBarScreens,
        ),
      );
    });
  }

  Widget _buildBottomNavBar() {
    return FlashyTabBar(
      showElevation: true,
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        _selectedIndex = index;
        tabController?.animateTo(index);
        setState(() {});
      },
      items: [
        FlashyTabBarItem(
          icon: const Icon(Icons.event),
          title: const Text('Events'),
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.search),
          title: const Text('Search'),
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.highlight),
          title: const Text('Highlights'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: _buildPageBody(),
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ),
    );
  }
}
