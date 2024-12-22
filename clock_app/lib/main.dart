import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  // Ensure widgets are initialized before setting full-screen mode
  WidgetsFlutterBinding.ensureInitialized();

  // Set app to fullscreen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(RealTimeClockApp());
}

class RealTimeClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dark theme
      home: RealTimeClockScreen(),
    );
  }
}

class RealTimeClockScreen extends StatefulWidget {
  const RealTimeClockScreen({super.key});

  @override
  _RealTimeClockScreenState createState() => _RealTimeClockScreenState();
}

class _RealTimeClockScreenState extends State<RealTimeClockScreen> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    Timer.periodic(const Duration(minutes: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  String _getCurrentTime() {
    // Format the time to show only hours and minutes
    return DateFormat('HH:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic font size based on the smaller of the width or height
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double fontSize = (screenWidth < screenHeight
        ? screenHeight
        : screenWidth) /
        2.7; // Adjust the divisor to control text size
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          _currentTime,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
