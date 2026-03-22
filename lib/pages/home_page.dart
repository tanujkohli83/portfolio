import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../sections/work_history_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';
import '../core/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  double _scrollOffset = 0.0;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    setState(() => activeIndex = index);
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Column(
        children: [
          CustomNavbar(
            activeIndex: activeIndex,
            onTabSelected: _scrollToSection,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      // Hero — receives scroll offset for parallax
                      KeyedSubtree(
                        key: _sectionKeys[0],
                        child: HeroSection(scrollOffset: _scrollOffset),
                      ),
                      KeyedSubtree(
                        key: _sectionKeys[1],
                        child: SkillsSection(scrollOffset: _scrollOffset),
                      ),
                      KeyedSubtree(
                        key: _sectionKeys[2],
                        child:
                            WorkHistorySection(scrollOffset: _scrollOffset),
                      ),
                      KeyedSubtree(
                        key: _sectionKeys[3],
                        child:
                            ProjectsSection(scrollOffset: _scrollOffset),
                      ),
                      KeyedSubtree(
                        key: _sectionKeys[4],
                        child: const ContactSection(),
                      ),
                      // Footer
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text(
            '© 2026 Tanuj Kohli',
            style: TextStyle(
              color: AppColors.textDim,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          Text(
            'Built with Flutter ❤',
            style: TextStyle(
              color: AppColors.textDim,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
