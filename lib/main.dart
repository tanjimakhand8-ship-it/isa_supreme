import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screens/main_shell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // সিস্টেম UI ওভারলে ট্রান্সপারেন্ট ও স্ট্যাটাসবার কালার
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0A0E21),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  // প্রথমবার লঞ্চ চেক
  final prefs = await SharedPreferences.getInstance();
  final bool firstLaunch = prefs.getBool('first_launch') ?? true;
  if (firstLaunch) {
    await prefs.setBool('first_launch', false);
  }
  runApp(IsaApp(isFirstLaunch: firstLaunch));
}

class IsaApp extends StatefulWidget {
  final bool isFirstLaunch;
  const IsaApp({super.key, required this.isFirstLaunch});

  @override
  State<IsaApp> createState() => _IsaAppState();
}

class _IsaAppState extends State<IsaApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // অ্যাপ ব্যাকগ্রাউন্ডে গেলে সিকিউরিটি মোড অ্যাক্টিভেট করা যায়
    if (state == AppLifecycleState.paused) {
      // লক মোড ট্রিগার (পরে ইমপ্লিমেন্ট)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISA SUPREME',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: SplashScreen(isFirstLaunch: widget.isFirstLaunch),
      builder: (context, child) {
        // গ্লোবাল এরর হ্যান্ডলিং বা লোডিং
        return child!;
      },
    );
  }
}

// স্প্ল্যাশ স্ক্রিন (ইন্টারঅ্যাকটিভ)
class SplashScreen extends StatefulWidget {
  final bool isFirstLaunch;
  const SplashScreen({super.key, required this.isFirstLaunch});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _animController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const MainShell(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // লোগো (এখানে perfect_logo ব্যবহার করা যায়, কিন্তু সরল রাখলাম)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.secondary],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.6),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'ISA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Orbitron',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'ISA SUPREME',
                  style: AppTheme.neonGlow(AppTheme.primary, fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  'Jarvis Prime',
                  style: TextStyle(
                    color: AppTheme.secondary.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 30),
                if (widget.isFirstLaunch)
                  Text(
                    'Welcome, Master',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
