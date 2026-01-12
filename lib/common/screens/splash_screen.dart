import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1A237E),
      body: SplashBody(),
    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const AppLogoSection(),
            const Spacer(flex: 1),
            const TextSection(),
            const Spacer(flex: 2),
            const GetStartedButton(),
            const SizedBox(height: 20),
            const EncryptionFooter(),
          ],
        ),
      ),
    );
  }
}

class AppLogoSection extends StatelessWidget {
  const AppLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00C853), width: 2),
                ),
                child: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              )
              .animate()
              .fade(duration: 800.ms)
              .scale(delay: 200.ms, curve: Curves.elasticOut),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'SecurePay',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ).animate().slideY(begin: 0.3, end: 0),
        const SizedBox(height: 12),
        const Text(
          'Secure Payments, Simplified',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        const SizedBox(height: 8),
        const Text(
          'Multi-layered security for your peace of mind',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ],
    ).animate(delay: 400.ms).fade();
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => context.push('/login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853), // Teal/Green color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ).animate(delay: 800.ms).fadeIn().moveY(begin: 20, end: 0);
  }
}

class EncryptionFooter extends StatelessWidget {
  const EncryptionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Protected by bank-level encryption',
      style: TextStyle(color: Colors.white38, fontSize: 12),
    ).animate(delay: 1000.ms).fade();
  }
}
