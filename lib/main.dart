import 'package:flutter/material.dart';
import 'package:simulado_detran/page/home_screen.dart';
import 'package:simulado_detran/util/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('Supabase URL: ${Env.supabaseUrl}');
  print('Supabase Anon Key: ${Env.supabaseAnonKey}');

  try {
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
