import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({super.key});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final List<String> _pin = [];
  static const int _maxPinLength = 6;

  void _handlePress(String value) {
    if (_pin.length < _maxPinLength) {
      setState(() {
        _pin.add(value);
      });

      // Check if PIN is complete after the update
      if (_pin.length == _maxPinLength) {
        _verifyPinAndNavigate();
      }
    }
  }

  void _verifyPinAndNavigate() {
    final enteredPin = _pin.join("");
    const correctPin =
        "123456"; // This would usually come from a Provider/Vault

    if (enteredPin == correctPin) {
      context.go('/transaction-dashboard');
    } else {
      
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() => _pin.clear());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid PIN. Please try again.')),
        );
      });
    }
  }

  void _handleBackspace() =>
      setState(() => _pin.isNotEmpty ? _pin.removeLast() : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF1A237E)),
      ),
      // Using LayoutBuilder to ensure we handle screen constraints
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Flexible(flex: 1, child: SizedBox(height: 20)),
                const HeaderSection(
                  title: 'Enter Your PIN',
                  subtitle: 'Use your 6-digit PIN to continue',
                ),
                const Flexible(flex: 1, child: SizedBox(height: 40)),
                PinDotIndicator(
                  activeCount: _pin.length,
                  totalDots: _maxPinLength,
                ),
                const Spacer(flex: 2),
                // Constraining the keypad to prevent horizontal overflow
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: NumericKeypad(
                    onNumberPressed: _handlePress,
                    onBackspacePressed: _handleBackspace,
                  ),
                ),
                const Spacer(flex: 1),
                const FooterLinks(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}

class PinDotIndicator extends StatelessWidget {
  final int activeCount;
  final int totalDots;

  const PinDotIndicator({
    super.key,
    required this.activeCount,
    this.totalDots = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        for (int i = 0; i < totalDots; i++) PinDot(isActive: i < activeCount),
      ],
    );
  }
}

class PinDot extends StatelessWidget {
  final bool isActive;
  const PinDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF1A237E) : Colors.transparent,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
    );
  }
}

class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onNumberPressed;
  final VoidCallback onBackspacePressed;

  const NumericKeypad({
    super.key,
    required this.onNumberPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    return Column(
      children: [
        ...keys.map(
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...row.map(
                (val) =>
                    PinButton(label: val, onTap: () => onNumberPressed(val)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Opacity(
              opacity: 0,
              child: PinButton(label: '', onTap: null),
            ), // Alignment placeholder
            PinButton(label: '0', onTap: () => onNumberPressed('0')),
            PinButton(
              label: '',
              icon: const Icon(
                Icons.backspace_outlined,
                color: Color(0xFF1A237E),
              ),
              onTap: onBackspacePressed,
            ),
          ],
        ),
      ],
    );
  }
}

class PinButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? icon;

  const PinButton({super.key, required this.label, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Material makes the button "ink" response look professional
      child: Material(
        color: Colors.grey.shade100,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height:
                70, // Fixed height for circularity, but contained within Row
            width: 70,
            alignment: Alignment.center,
            child:
                icon ??
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.fingerprint),
          label: const Text('Use Biometric Instead'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF1A237E)),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot PIN?',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
