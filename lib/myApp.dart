import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/water_cubit.dart';
import 'pages/dashboard_page.dart';
import 'pages/history_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WaterCubit(),
      child: MaterialApp(
        title: 'Água Diária',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Rota inicial para a SplashScreen
        routes: {
          '/': (context) => const SplashPage(), // Rota para a SplashScreen
          '/dashboard': (context) => const DashboardPage(),
          '/history': (context) => const HistoryPage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}