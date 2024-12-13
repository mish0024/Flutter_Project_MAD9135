import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:final_project/screens/enter_code_screen.dart';
import 'package:final_project/screens/share_code_screen.dart';
import 'package:final_project/screens/movie_selection_screen.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text('Movie Night'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShareCodeScreen(),
                    ));
                    
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Start Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Please Choose Your Option',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Spacer(flex: 3),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnterCodeScreen(),
                    ));
                    
              },
              icon: const Icon(Icons.code),
              label: const Text('Enter Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeDeviceId() async {
    String deviceId = await _fetchDeviceId();
    Provider.of<AppState>(context, listen: false).setDeviceId(deviceId);
  }

  Future<String> _fetchDeviceId() async {
    String deviceId = "";

    try {
      if (Platform.isAndroid) {
        const androidPlugin = AndroidId();
        deviceId = await androidPlugin.getId() ?? 'Unknown id';
      } else if (Platform.isIOS) {
        var deviceInfoPlugin = DeviceInfoPlugin();
        var iOSInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iOSInfo.identifierForVendor ?? 'Unknown id';
      } else {
        deviceId = 'Unsupported platform';
      }
    } catch (e) {
      deviceId = 'Error: $e';
    }

    if (kDebugMode) {
      print('Device id: $deviceId');
    }
    return deviceId;
  }
}
