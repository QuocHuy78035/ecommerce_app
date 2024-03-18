import 'package:ecomerce_app/buyers/views/auth/login_screen.dart';
import 'package:ecomerce_app/providers/cart_provider.dart';
import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:ecomerce_app/vendors/views/auth/widgets/vendor_register_account_screen.dart';
import 'package:ecomerce_app/vendors/views/auth/widgets/vendor_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Brand-Bold',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VendorRegisterAccount(),
      builder: EasyLoading.init(),
    );
  }
}
