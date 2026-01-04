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
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Enter phone or account number',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: const Icon(Icons.alternate_email_rounded, size: 20),
            // Suffix icon logic: Loading vs Verified vs Contacts
            suffixIcon: isValidating
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : isVerified
                ? const Icon(Icons.check_circle, color: Colors.green)
                : IconButton(
                    icon: const Icon(Icons.contact_page_outlined),
                    onPressed: onContactTap,
                  ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            errorText: errorText, // Displays the "User not found" error
          ),
        ),
        // Verification Label
        if (isVerified)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              'Recipient: $verifiedName',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }
}
