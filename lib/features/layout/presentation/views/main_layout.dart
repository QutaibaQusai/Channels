import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:channels/features/layout/presentation/widgets/floating_nav_bar.dart';
import 'package:channels/features/layout/presentation/widgets/layout_app_bar.dart';
import 'package:channels/features/broadcasts/presentation/views/broadcasts_view.dart';
import 'package:channels/features/categories/presentation/views/categories_view.dart';
import 'package:channels/features/ai/presentation/views/ai_view.dart';

/// Main layout with floating navigation bar and page navigation
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late final PageController _pageController;
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pages = [
      const BroadcastsView(), // Index 0 - Broadcasts
      const CategoriesView(), // Index 1 - Categories
      const AiView(), // Index 2 - AI (plus button on right)
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    HapticFeedback.mediumImpact();
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppBar(currentIndex: _currentIndex),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      floatingActionButton: FloatingNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
