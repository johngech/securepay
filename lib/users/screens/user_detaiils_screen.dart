import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/widgets.dart';
import 'package:securepay/users/user_providers.dart';
import 'package:securepay/users/widgets.dart';
import 'package:securepay/settings/widgets.dart';

class UserDetailsScreen extends ConsumerWidget {
  final int userId;
  const UserDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userDetailsProvider(userId));
    final form = ref.watch(registrationFormProvider);
    final isUpdating = ref.watch(userUpdateLoadingProvider);

    ref.listen(userDetailsProvider(userId), (previous, next) {
      next.whenData((user) {
        // We only patch if the user hasn't modified the form yet
        if (form.pristine) {
          form.patchValue({
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
          });
        }
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const SettingsAppBar(title: "User Profile"),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Error loading profile: $err"),
              TextButton(
                onPressed: () => ref.invalidate(userDetailsProvider(userId)),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
        data: (user) => ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: ProfileAvatarSection()),
                const SizedBox(height: 32),
                const SectionTitle(title: "Personal Information"),
                const SizedBox(height: 16),

                // Form Fields
                UserFormInput(
                  formControlName: 'firstName',
                  label: 'First Name',
                  icon: Icons.person_outline,
                ),
                UserFormInput(
                  formControlName: 'lastName',
                  label: 'Last Name',
                  icon: Icons.person_outline,
                ),
                UserFormInput(
                  formControlName: 'email',
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 32),

                // Update Button
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return PrimaryButton(
                      label: isUpdating
                          ? "Saving Changes..."
                          : "Update Profile",
                      onPressed: (form.valid && !isUpdating)
                          ? () => _handleUpdate(context, ref, form)
                          : null,
                    );
                  },
                ),

                const SizedBox(height: 32),
                const SectionTitle(title: "Linked Devices"),
                const SlidableDeviceItem(
                  deviceName: "iPhone 15 Pro",
                  location: "Addis Ababa, ET",
                ),
                const SizedBox(height: 40),
                const LogoutButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpdate(
    BuildContext context,
    WidgetRef ref,
    FormGroup form,
  ) async {
    // Start Loading
    ref.read(userUpdateLoadingProvider.notifier).state = true;

    try {
      final service = ref.read(userServiceProvider);

      // Create User object from form values
      final updatedUser = User(
        id: userId.toString(),
        firstName: form.control('firstName').value,
        lastName: form.control('lastName').value,
        email: form.control('email').value,
      );

      // Perform PUT request via Generic Service
      await service.update(userId, updatedUser.toJson());

      // Invalidate providers to force a fresh fetch on the list and details
      ref.invalidate(usersListProvider);
      ref.invalidate(userDetailsProvider(userId));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
        // Mark form as pristine again so it doesn't trigger "unsaved changes" warnings
        form.markAsPristine();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Update failed: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      // Stop Loading
      ref.read(userUpdateLoadingProvider.notifier).state = false;
    }
  }
}
