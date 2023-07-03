import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:sunackubaru/core/client/client.dart';

class SettingsProvider with ChangeNotifier {
  String? _code;
  String? get code => _code;

  Future<void> connectToGitHub() async {
    final Uri uri = Uri.https(
      'github.com',
      '/login/oauth/authorize',
      <String, String>{
        'client_id': Client.id,
        // TODO(tun43p): Update redirect URL
        'redirect_uri': 'com.tun43p.sunackubaru',
        'scope': 'public_repo'
      },
    );

    try {
      final String result = await FlutterWebAuth2.authenticate(
        url: uri.toString(),
        // TODO(tun43p): Update redirect URL
        callbackUrlScheme: 'com.tun43p.sunackubaru',
      );

      final String? code = Uri.parse(result).queryParameters['code'];

      if (code == null) {
        throw Exception('No code returned from GitHub');
      }

      _code = code;
    } on PlatformException catch (error, stackTrace) {
      debugPrint(
        <Object?>[
          error.code,
          error.message,
          stackTrace,
        ].join('\n '),
      );
    } catch (error, stackTrace) {
      debugPrint(<Object>[error, stackTrace].join('\n '));
    }
  }
}
