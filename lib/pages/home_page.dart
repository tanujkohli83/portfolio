import 'package:flutter/material.dart';
import '../../widgets/custom_navbar.dart';
import '../../sections/hero_section.dart';
import '../../sections/skills_section.dart';
import '../../sections/work_history_section.dart';
import '../../sections/projects_section.dart';
import '../../sections/contact_section.dart';
import '../../core/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _sectionKeys = List.generate(5, (index) => GlobalKey());

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
                      HeroSection(key: _sectionKeys[0]),
                      SkillsSection(key: _sectionKeys[1]),
                      WorkHistorySection(key: _sectionKeys[2]),
                      ProjectsSection(key: _sectionKeys[3]),
                      ContactSection(key: _sectionKeys[4]),
                      const SizedBox(height: 100),
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
}
