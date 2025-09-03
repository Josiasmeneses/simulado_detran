import 'dart:html' as html;

class Env {
  static String? getMeta(String name) {
    final meta = html.document.head?.querySelector('meta[name="$name"]');
    return meta?.getAttribute('content');
  }

  static String get supabaseUrl {
    final url = getMeta('SUPABASE_URL');
    if (url == null || url.isEmpty) {
      throw Exception('SUPABASE_URL não encontrado nas meta tags');
    }
    return url;
  }

  static String get supabaseAnonKey {
    final key = getMeta('SUPABASE_ANON_KEY');
    if (key == null || key.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY não encontrado nas meta tags');
    }
    return key;
  }
}

  // static String get supabaseUrl =>
  //     getMeta('SUPABASE_URL') ?? 'https://tjzphihmvagmmfwqpjjn.supabase.co';

  // static String get supabaseAnonKey =>
  //     getMeta('SUPABASE_ANON_KEY') ??
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqenBoaWhtdmFnbW1md3FwampuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY3NDg2MDUsImV4cCI6MjA3MjMyNDYwNX0.18RLWI9Rgnm-E_o_4S7GsiAZULPpYZMkkBUBjdcKvqs';