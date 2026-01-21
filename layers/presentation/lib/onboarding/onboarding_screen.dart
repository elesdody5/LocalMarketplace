import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/routes/routes.dart';
import '../theme/app_colors.dart';
import '../welcome/welcome_screen.dart';
import 'widgets/onboarding_skip_button.dart';
import 'widgets/onboarding_page_indicator.dart';
import 'widgets/onboarding_action_button.dart';
import 'widgets/onboarding_image_card.dart';
import 'widgets/onboarding_secure_chat_illustration.dart';
import 'widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      titleKey: 'onboarding_discover_title',
      descriptionKey: 'onboarding_discover_description',
      imagePath: 'assets/images/onboarding_buy.webp',
      isAsset: true,
    ),
    OnboardingPageData(
      titleKey: 'onboarding_connect_title',
      descriptionKey: 'onboarding_connect_description',
      imagePath: 'assets/images/onboarding_sell.webp',
      isAsset: true,
    ),
    OnboardingPageData(
      titleKey: 'onboarding_secure_title',
      descriptionKey: 'onboarding_secure_description',
      useSecureChatIllustration: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  void _skipOnboarding() {
    Get.offNamed(welcomeRouteName);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final backgroundColor = isDark ? AppColors.backgroundDark : const Color(0xFFf4f9fc);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            OnboardingSkipButton(onPressed: _skipOnboarding),

            // PageView with images
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildPageContent(_pages[index]);
                },
              ),
            ),

            // Bottom content card
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title and Description
                  OnboardingContent(
                    titleKey: _pages[_currentPage].titleKey,
                    descriptionKey: _pages[_currentPage].descriptionKey,
                  ),
                  const SizedBox(height: 32),

                  // Page indicators and button
                  Column(
                    children: [
                      // Page indicators
                      OnboardingPageIndicator(
                        currentPage: _currentPage,
                        totalPages: _pages.length,
                      ),
                      const SizedBox(height: 24),

                      // Next button
                      OnboardingActionButton(
                        onPressed: _nextPage,
                        isLastPage: _currentPage == _pages.length - 1,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPageData page) {
    // ✅ Wrap in RepaintBoundary to prevent expensive repaints
    return RepaintBoundary(
      child: page.useSecureChatIllustration
          ? const OnboardingSecureChatIllustration()
          : OnboardingImageCard(
              imagePath: page.imagePath ?? '',
              isAsset: page.isAsset,
            ),
    );
  }
}

class OnboardingPageData {
  final String titleKey;
  final String descriptionKey;
  final String? imagePath;
  final bool isAsset;
  final bool useSecureChatIllustration;

  OnboardingPageData({
    required this.titleKey,
    required this.descriptionKey,
    this.imagePath,
    this.isAsset = true,
    this.useSecureChatIllustration = false,
  });
}



