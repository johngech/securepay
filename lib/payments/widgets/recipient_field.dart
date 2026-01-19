import 'package:flutter/material.dart';

class RecipientField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVerified;
  final bool isValidating;
  final String verifiedName;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final VoidCallback onContactTap;

  const RecipientField({
    super.key,
    required this.controller,
    required this.isVerified,
    required this.isValidating,
    required this.verifiedName,
    required this.onChanged,
    required this.onContactTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Phone number or ID',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: const Color(0xFFF8F9FE),
            prefixIcon: const Icon(Icons.person_outline_rounded),
            suffixIcon: _buildSuffix(),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isVerified ? Colors.green.shade200 : Colors.transparent,
              ),
            ),
            errorText: errorText,
          ),
        ),
        if (isVerified)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Verified: $verifiedName',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSuffix() {
    if (isValidating) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (isVerified) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    return IconButton(
      icon: const Icon(Icons.contact_page_outlined),
      onPressed: onContactTap,
    );
  }
}
