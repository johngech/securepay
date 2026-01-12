import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/navigation.dart';

class MainBottomNav extends StatelessWidget {
  final List<NavDestination> destinations;
  final StatefulNavigationShell shell;

  const MainBottomNav({
    super.key,
    required this.destinations,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(179, 216, 231, 238),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24,
                    color: Colors.black.withValues(alpha: 0.08),
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(destinations.length, (index) {
                  final destination = destinations[index];
                  final selected = shell.currentIndex == index;

                  return Expanded(
                    child: _NavItem(
                      destination: destination,
                      selected: selected,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        shell.goBranch(index);
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        )
        // Entrance animation
        .animate()
        .slideY(
          begin: 0.4,
          end: 0,
          curve: Curves.easeOutCubic,
          duration: 400.ms,
        )
        .fadeIn(duration: 300.ms);
  }
}

class _NavItem extends StatelessWidget {
  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: SizedBox(
        height: 56, // HARD CONSTRAINT (prevents overflow)
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Icon(
                    destination.icon,
                    size: 24,
                    color: selected ? cs.primary : cs.onSurfaceVariant,
                  )
                  // Icon animation
                  .animate(target: selected ? 1 : 0)
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.15, 1.15),
                    curve: Curves.easeOutBack,
                    duration: 250.ms,
                  ),

              Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      color: selected
                          ? cs.primary
                          : cs.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  )
                  // Label animation
                  .animate(target: selected ? 1 : 0)
                  .fadeIn(duration: 200.ms)
                  .slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
