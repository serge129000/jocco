import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/utils/theme_data.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StepProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        title: 'Jocco',
        home: const SplashScreen(),
        theme: Themes.appTheme,
      ),
    );
  }
}
