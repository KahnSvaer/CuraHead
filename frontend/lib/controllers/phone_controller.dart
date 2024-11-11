import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class UrlController {

  static Future<void> launchPhoneNumber(String phoneNumber) async {
    try {
      PermissionStatus status = await Permission.phone.request();

      if (status.isGranted) {

        final Uri url = Uri(
          scheme: 'tel',
          path: phoneNumber,  // Ensure phone number format is like '+1234567890'
        );

        status = await Permission.phone.status;

        if (status.isGranted) {
          await launchUrl(url);
        } else {
          throw 'Permission to make phone calls is denied after being granted';
        }
      } else {
        throw 'Permission to make phone calls is denied';
      }
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Optional: to hide debug banner
      home: Scaffold(
        appBar: AppBar(title: Text('URL Launcher Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String phoneNumber = '';
              try {
                await UrlController.launchPhoneNumber(phoneNumber);
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Permission Error'),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Call '),
          ),
        ),
      ),
    );
  }
}
