import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:store_mg_fl/features/auth/views/auth_screen.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:store_mg_fl/features/products/views/products_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      title: 'store mg',
      theme: ShadThemeData(
        colorScheme: ShadBlueColorScheme.light(
          primary: Colors.cyan[400]!,
          secondary: Colors.deepOrangeAccent,
          // foreground: Colors.white,
          // background: Colors.grey[600]!,
        ),
        brightness: Brightness.light,
      ),
      home: const ProductsScreen(),
      routes: {
        AuthScreen.routeName: (context) => const ProductsScreen(),
        ProductsScreen.routeName: (context) => const ProductsScreen(),
      },
    );
  }
}
