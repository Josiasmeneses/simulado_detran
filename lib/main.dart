import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simulado_detran/page/home_screen.dart';
import 'package:simulado_detran/util/env_mobile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (!kIsWeb) {
      await dotenv.load(fileName: ".env");
    }

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      debug: true,
    );
    print('Banco conectado');
  } catch (e) {
    print('Banco não inicializado: $e');
  }
  runApp(SimuladorApp());
}

class SimuladorApp extends StatelessWidget {
  const SimuladorApp({super.key});

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulado Detran',
      theme: ThemeData(fontFamily: 'Arial', primarySwatch: Colors.grey),
      home: HomeScreen(),
    );
  }
}

  //   try {
  //     final client = Supabase.instance.client;
  //     isInitialized = client != null;
  //   } catch (e) {
  //     isInitialized = false;
  //   }

  //   if (!isInitialized) {
  //     await Supabase.initialize(
  //       url: Env.supabaseUrl,
  //       anonKey: Env.supabaseAnonKey,
  //       debug: true,
  //     );
  //   }
  //   print(' Banco conectado com sucesso');
  // } catch (e) {
  //   print(("Banco não inicializado: $e"));
  // }