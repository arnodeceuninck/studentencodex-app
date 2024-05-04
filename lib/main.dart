import 'package:codex/presentation/model_theme.dart';
import 'package:flutter/material.dart';
import 'package:codex/presentation/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          title: 'Antwerpse Codex',
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                )
              : ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.red,
                  ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
          home: const HomePage(),
        );
      }),
    );
  }
}
