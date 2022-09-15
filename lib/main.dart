import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const LICENSE_KEY =
      "ImVp6DrMzXjzvI8Kfp0VitWGZEHyQvNMSTtoBi2U4gm7npQXnuCCW2Wg3pOfQqFkUy8czIgYf1qCGSIYt2RPU4v8XNdjXMRq3fiN2xvGzMSgikkMF6YY62NUrMcjVVouaeWV9b7X/Ff0ZS4t2jrHJWOLPSPLAAglwQ7j/F5PYZu23TyPnRkmxwJ+QWUszbq+rMqtmeXALqAo50EyI3tsw5PIYH//Z4aw79bCucm+KOWyclhHesqGUE5bPWeqI1N2DoSW6XSX4/eYKwcli5tqCVqSXLn7MWvq0pkL1xKs3oaGtS+xFiqHfWtSIAoDT+hIvnYsbj9PSUg70hhzSRO3yg==\nU2NhbmJvdFNESwpjb20uZXhhbXBsZS5zY2FuYm90X2RlbW8KMTY2Mzg5MTE5OQo4Mzg4NjA3CjM=\n";

  @override
  Widget build(BuildContext context) {
    ScanbotSdk.initScanbotSdk(
        ScanbotSdkConfig(loggingEnabled: true, licenseKey: LICENSE_KEY));
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}
