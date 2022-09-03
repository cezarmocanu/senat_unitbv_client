import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/pages/login.dart';
import 'package:senat_unit_bv/pages/main_scaffold.dart';
import 'package:senat_unit_bv/pages/splash_page.dart';
import 'package:senat_unit_bv/store/meeting_slice.dart';
import 'package:senat_unit_bv/store/user_slice.dart';
import 'package:senat_unit_bv/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserSlice()),
        ChangeNotifierProvider(create: (context) => MeetingSlice()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senat Unitbv',
      theme: AppTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => MainScaffoldPage(),
      },
    );
  }
}
