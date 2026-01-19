import 'package:flutter/material.dart';

class AmountInput extends StatelessWidget {
  final String balance;
  final TextEditingController controller;

  const AmountInput({
    super.key, 
    required this.balance, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enter Amount',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () => controller.text = balance.replaceAll(',', ''),
                child: Text(
                  'Use Max',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              prefixText: '\$ ',
              prefixStyle: TextStyle(fontSize: 36, color: Colors.black),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(),
          Text(
            'Available Balance: \$$balance',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}