
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:securepay/common/services/dio_factory.dart';

class ResolvedUser {
  final int id;
  final String fullName;
  final String contact;

  ResolvedUser({
    required this.id,
    required this.fullName,
    required this.contact,
  });

  factory ResolvedUser.fromJson(Map<String, dynamic> json) {
    return ResolvedUser(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      contact: json['contact'] as String,
    );
  }
}

class RecipientState {
  final ResolvedUser? user;
  final bool isValidating;
  final String? errorMessage;

  RecipientState({this.user, this.isValidating = false, this.errorMessage});

  RecipientState copyWith({ResolvedUser? user, bool? isValidating, String? errorMessage}) {
    return RecipientState(
      user: user ?? this.user,
      isValidating: isValidating ?? this.isValidating,
      errorMessage: errorMessage, // We allow resetting to null
    );
  }
}

class RecipientNotifier extends StateNotifier<RecipientState> {
  final Ref ref;
  Timer? _debounceTimer;

  RecipientNotifier(this.ref) : super(RecipientState());

  void onInputChanged(String input) {
    _debounceTimer?.cancel();
    
    if (input.isEmpty) {
      state = RecipientState();
      return;
    }

    // Debounce to avoid hitting the server on every keystroke
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      _resolveRecipient(input);
    });
  }

  Future<void> _resolveRecipient(String input) async {
    state = state.copyWith(isValidating: true, errorMessage: null);

    try {
      final dio = ref.read(dioProvider);
      
      // Determine if input is email or phone
      final bool isEmail = input.contains('@');
      final Map<String, dynamic> requestBody = isEmail 
          ? {"email": input, "phone": ""} 
          : {"email": "", "phone": input};

      final response = await dio.post('/users/resolve', data: requestBody);
      
      final resolvedUser = ResolvedUser.fromJson(response.data);
      state = state.copyWith(user: resolvedUser, isValidating: false);
      
    } catch (e) {
      state = state.copyWith(
        isValidating: false, 
        errorMessage: "Recipient not found",
        user: null,
      );
    }
  }
}

final recipientLookupProvider = StateNotifierProvider.autoDispose<RecipientNotifier, RecipientState>((ref) {
  return RecipientNotifier(ref);
});