class SecurityConfig {
  final bool isBiometricEnabled;
  final bool isAutoLogoutEnabled;
  final int sessionTimeoutMinutes;

  const SecurityConfig({
    required this.isBiometricEnabled,
    required this.isAutoLogoutEnabled,
    required this.sessionTimeoutMinutes,
  });
}
