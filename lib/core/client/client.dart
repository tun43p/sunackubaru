class Client {
  static String id = const String.fromEnvironment('CLIENT_ID');
  static String secret = const String.fromEnvironment('CLIENT_SECRET');
  static String redirect = const String.fromEnvironment('REDIRECT_URI');
}
