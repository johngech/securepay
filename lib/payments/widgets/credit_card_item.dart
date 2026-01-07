import 'package:flutter/material.dart';

class CreditCardItem extends StatelessWidget {
  final String lastFour;
  final String expiry;

  const CreditCardItem({
    super.key,
    required this.lastFour,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF263238),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.credit_card, color: Colors.amber, size: 20),
      ),
      title: Text('•••• $lastFour', style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Expires $expiry', style: const TextStyle(fontSize: 12)),
      trailing: TextButton(
        onPressed: () {},
        child: const Text('Edit', style: TextStyle(color: Color(0xFF1A237E))),
      ),
    );
  }
}