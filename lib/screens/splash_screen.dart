import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donghanh_flutter/generated/l10n.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isConnected = true;
  bool _isLoading = true;  // Indicates whether the connection is being checked

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  // Function to check network connection
  Future<void> _checkConnection() async {
    setState(() {
      _isLoading = true;  // Start loading when checking connection
    });
    await Future.delayed(Duration(seconds: 2)); // Mock login delay
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
        _isLoading = false;  // Stop loading if no connection
      });
    } else {
      setState(() {
        _isConnected = true;
        _isLoading = false;  // Stop loading after checking connection
      });
      // Navigate to the login screen after checking connectivity
      // Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_logo.png', height: 120),  // Display splash image
            SizedBox(height: 20),
            Text(
              S.of(context).wellcometoapp,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            if (_isLoading)  // Show loading spinner while checking connection
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            if(!_isLoading)
               SizedBox(height: 40),
            if (!_isLoading && !_isConnected)  // Show retry button if no internet
              Column(
                children: [
                  Text(
                    S.of(context).nonetwork,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _checkConnection();  // Retry checking connection
                    },
                    child: Text('Retry'),                   
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
