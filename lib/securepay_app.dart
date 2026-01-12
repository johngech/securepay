import 'package:flutter/material.dart';
// import 'package:securepay/app_router.dart';
import 'package:securepay/router_config.dart';

class SecurepayApp extends StatelessWidget {
  const SecurepayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SecurePay',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: routerConfig,
    );
  }
}
