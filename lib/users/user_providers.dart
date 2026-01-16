import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/http_service.dart';
import 'package:securepay/common/services/services.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

final registrationFormProvider = Provider.autoDispose((ref) {
  return fb.group(
    {
      'firstName': [
        '',
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(25),
      ],
      'lastName': [
        '',
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(25),
      ],
      'email': ['', Validators.required, Validators.email],
      'phoneNumber': [
        '',
        Validators.required,
        Validators.pattern(r'^\+?[0-9]{10,15}$'),
      ],
      'password': ['', Validators.required, Validators.minLength(8)],
      'confirmPassword': ['', Validators.required],
    },
    [Validators.mustMatch('password', 'confirmPassword')],
  );
});

final userServiceProvider = Provider<GenericHttpService<User>>((ref) {
  final dio = ref.watch(dioProvider);

  return createHttpService<User>(
    dio: dio,
    endpoint: "/users",
    fromJson: (json) => User.fromJson(json),
  );
});

final usersListProvider = FutureProvider.autoDispose<List<User>>((ref) {
  final service = ref.watch(userServiceProvider);
  return service.getAll(); // Uses the logic inside GenericHttpService
});

final userUpdateLoadingProvider = StateProvider<bool>((ref) => false);

final userDetailsProvider = FutureProvider.autoDispose.family<User, int>((
  ref,
  userId,
) async {
  final service = ref.watch(userServiceProvider);
  return service.getById(userId);
});
