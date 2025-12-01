import 'package:flood_detection/widgets/header_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final activeTabColor = const Color(0xFF007B9A);
  final inactiveTabColor = const Color(0xFF004D7A);
  final unselectedLabelColor = const Color(0xFFB3C5D0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.index != _currentIndex) {
          setState(() => _currentIndex = _tabController.index);
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Stack(
      children: [
        Scaffold(
          appBar: HeaderHome(
            tabController: _tabController,
            currentIndex: _currentIndex,
            activeColor: activeTabColor,
            inactiveColor: inactiveTabColor,
            unselectedLabelColor: unselectedLabelColor,
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [DashboardScreen(), HistoryScreen()],
          ),
        ),

        if (auth.isAuthenticating)
          Container(
            color: Colors.black45,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
