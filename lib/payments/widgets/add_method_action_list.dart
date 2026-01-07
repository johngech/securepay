import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:securepay/payments/widgets.dart';

class AddMethodActionList extends StatelessWidget {
  const AddMethodActionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddMethodButton(
          label: 'Apple Pay',
          icon: Icons.apple,
          color: Colors.black,
        ),
        const SizedBox(height: 12),
        const AddMethodButton(
          label: 'Google Pay',
          icon: Icons.g_mobiledata,
          color: Color(0xFF4285F4),
        ),
        const SizedBox(height: 12),
        const AddMethodButton(
          label: 'Venmo',
          icon: Icons.attach_money,
          color: Color(0xFF3D95CE),
        ),
        const SizedBox(height: 16),
        const DottedAddCardButton(),
      ],
    ).animate(delay: 100.ms).fadeIn().slideX(begin: 0.1);
  }
}

class AddMethodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const AddMethodButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
