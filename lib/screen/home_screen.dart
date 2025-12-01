import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0; // State untuk melacak tab yang aktif

  final activeTabColor = const Color(0xFF007B9A);
  final inactiveTabColor = const Color(0xFF004D7A);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Tambahkan listener untuk mendeteksi perubahan tab
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // Memastikan perubahan terjadi saat pengguna mengklik tab (indexIsChanging = false saat dianimasikan)
    // atau jika animasi selesai (indexIsChanging = true saat mulai/berakhir swipe).
    if (_tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  // --- Widget Kustom untuk Tab Item (Dengan Background Penuh) ---
  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _currentIndex == index;
    
    return Container(
      // Dekorasi akan menentukan warna latar belakang penuh tab
      decoration: BoxDecoration(
        color: isSelected ? activeTabColor : inactiveTabColor,
        // Optional: Jika Anda ingin sudut melengkung, Anda bisa menambahkannya di sini.
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10), // Padding internal agar teks terlihat rapi
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flood\'nt?!', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: inactiveTabColor, 
            child: TabBar(
              controller: _tabController,
              // Matikan semua indikator bawaan karena kita menggunakan dekorasi kustom pada Tab item
              indicatorPadding: EdgeInsets.zero,
              indicatorWeight: 0, 
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent, 
              
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              
              // Menggunakan custom Tab widget untuk mengontrol background
              tabs: [
                Tab(child: _buildTabItem(title: 'Dashboard', index: 0)),
                Tab(child: _buildTabItem(title: 'History', index: 1)),
              ],
              
              // Memberi indikator dekorasi kosong
              indicator: const BoxDecoration(color: Colors.transparent),
              
              // Penting: Mengatur tab agar merenggang dan mengisi ruang
              labelPadding: EdgeInsets.zero,
              
              // Agar item Tab menutupi seluruh lebar TabBar
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DashboardScreen(),
          HistoryScreen(),
        ],
      ),
    );
  }
}
