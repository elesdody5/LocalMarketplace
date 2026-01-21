import 'package:flutter/material.dart';

class OnboardingSecureChatIllustration extends StatelessWidget {
  const OnboardingSecureChatIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final backgroundColor = isDark
        ? const Color(0xFF1e293b).withValues(alpha: 0.5)
        : const Color(0xFFe8efeb);
    final chatBubbleColor = const Color(0xFF0c5678).withValues(alpha: 0.2);
    final lockCardColor = isDark ? const Color(0xFF334155) : Colors.white;
    final shadowColor = Colors.black.withValues(alpha: 0.05);
    final dotColor = const Color(0xFF0c5678).withValues(alpha: 0.3);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 32),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: backgroundColor,
              ),
              child: Center(
                child: SizedBox(
                  width: 192,
                  height: 192,
                  child: Stack(
                    children: [
                      // Chat bubble with dots (sender) - ✅ Wrapped in RepaintBoundary
                      Positioned(
                        top: 16,
                        left: 16,
                        child: RepaintBoundary(
                          child: Container(
                            width: 128,
                            height: 96,
                            decoration: BoxDecoration(
                              color: chatBubbleColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildDot(dotColor),
                                  const SizedBox(width: 6),
                                  _buildDot(dotColor),
                                  const SizedBox(width: 6),
                                  _buildDot(dotColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Lock icon card (secure) - ✅ Wrapped in RepaintBoundary
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: RepaintBoundary(
                          child: Container(
                            width: 128,
                            height: 96,
                            decoration: BoxDecoration(
                              color: lockCardColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColor,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.lock_outline,
                                size: 48,
                                color: Color(0xFF0c5678),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot(Color dotColor) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

