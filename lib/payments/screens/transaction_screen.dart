import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HistoryAppBar(),
      body: Column(
        children: [
          const HistorySearchAndFilter(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: const [
                  SizedBox(height: 24),
                  SummaryCardsRow(),
                  SizedBox(height: 24),
                  TransactionList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Color(0xFF1A237E)),
      title: const Text(
        'Transaction History',
        style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.download_rounded, color: Color(0xFF1A237E)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HistorySearchAndFilter extends StatelessWidget {
  const HistorySearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              FilterChip(label: 'All', isActive: true),
              SizedBox(width: 8),
              FilterChip(label: 'Sent', isActive: false),
              SizedBox(width: 8),
              FilterChip(label: 'Received', isActive: false),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: SummaryCard(
            label: 'Total Sent',
            amount: '259.14',
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            label: 'Total Received',
            amount: '3475.00',
            color: Color(0xFF00C853),
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            '\$$amount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        // Mock data for the specific items in your screenshot
        return const TransactionItemTile();
      },
    );
  }
}

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFE8EAF6),
          child: Icon(Icons.arrow_upward, size: 18, color: Color(0xFF1A237E)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Starbucks Coffee',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Dec 2, 2025 at 10:30 AM',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
        ),
        const Text(
          '\$5.99',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const FilterChip({super.key, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1A237E) : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
