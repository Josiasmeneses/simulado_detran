export 'env_mobile.dart' if (dart.library.html) 'env_web.dart';

class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}
// import 'package:flutter/foundation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class Env {
//   static String get supabaseUrl {
//     if (kIsWeb) {
//       return const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
//     } else {
//       final url = dotenv.env['SUPABASE_URL'];
//       if (url == null || url.isEmpty) {
//         throw Exception('SUPABASE_URL Não encontrado em Arquivo .Env');
//       }
//       return url;
//     }
//   }

//   static String get supabaseAnonKey {
//     if (kIsWeb) {
//       return const String.fromEnvironment(
//         'SUPABASE_ANON_KEY',
//         defaultValue: '',
//       );
//     } else {
//       final key = dotenv.env['SUPABASE_ANON_KEY'];
//       if (key == null || key.isEmpty) {
//         throw Exception('SUPABASE_ANON_KEY Não encontrado em Arquivo .Env');
//       }
//       return key;
//     }
//   }
// }
