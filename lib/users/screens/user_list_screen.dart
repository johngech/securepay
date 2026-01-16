import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/themes.dart';
import 'package:securepay/users/user_providers.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        title: const Text("SecurePay Directory"),
        backgroundColor: AppColors.bgGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(usersListProvider),
          ),
        ],
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text("No users found."));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: users.length,
            separatorBuilder: (context, index) => const Divider(height: 0.5),
            itemBuilder: (context, index) {
              final user = users[index];

              // Get Initials: F from FirstName and L from LastName
              final initials = "${user.firstName[0]}${user.lastName[0]}"
                  .toUpperCase();

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  child: Text(
                    initials,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text(user.email),
                onTap: () => context.push("/users/${user.id}"),
              );
            },
          );
        },
      ),
    );
  }
}
