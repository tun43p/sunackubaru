// ignore_for_file: unnecessary_const, we need const for environment variables

class EnvService {
  static const String clientId = const String.fromEnvironment('CLIENT_ID');

  static const String clientSecret =
      const String.fromEnvironment('CLIENT_SECRET');
}
