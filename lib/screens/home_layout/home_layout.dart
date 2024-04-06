import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/screens/home_layout/home_page.dart';
import 'package:music_player/services/favorite_service.dart';
import 'package:music_player/services/music_service.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/common/bottom_panel.dart';
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

  late MainStore mainStore;
  TabController? tabController;
  bool showingIncomingRequestPopup = false;

  PanelController get _panelController {
    return mainStore.audioPlayerStore.panelController;
  }

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
    FavoritesService.instance.setMainStoreReference(mainStore);
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

  Widget _buildPageBody() {
    return Observer(builder: (context) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;

      return SlidingUpPanel(
        minHeight: track != null ? 115 : 0,
        renderPanelSheet: true,
        panelSnapping: true,
        disableDraggableOnScrolling: true,
        controller: _panelController,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        panelBuilder: () => Container(),
        collapsed: panelCollapsedView(),
        body: const HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: context.theme.statusBarBrightness,
        statusBarIconBrightness: context.theme.statusBarIconBrightness,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: context.theme.pageBackgroundColor,
          body: _buildPageBody(),
        ),
      ),
    );
  }
}
