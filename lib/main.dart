import 'package:flutter/material.dart';
import 'package:jocco/core/utils/theme_data.dart';
import 'package:jocco/views/providers/step_provider.dart';
import 'package:jocco/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> StepProvider())
      ],
      child: MaterialApp(
        title: 'Jocco',
        home: const SplashScreen(),
        theme: Themes.appTheme,
      ),
    );
  }
}
