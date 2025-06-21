import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_farming_app/providers/auth_provider.dart';
import 'package:urban_farming_app/providers/product_provider.dart';
import 'package:urban_farming_app/providers/transaction_provider.dart';
import 'package:urban_farming_app/screens/auth/login_screen.dart';
import 'package:urban_farming_app/screens/main_screen.dart';
import 'package:urban_farming_app/services/auth_service.dart';
import 'package:urban_farming_app/services/product_service.dart';
import 'package:urban_farming_app/services/transaction_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService: AuthService()),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (_) => ProductProvider(ProductService(), null),
          update: (_, authProvider, productProvider) =>
              ProductProvider(ProductService(), authProvider.user),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TransactionProvider>(
          create: (_) => TransactionProvider(TransactionService(), null),
          update: (_, authProvider, transactionProvider) =>
              TransactionProvider(TransactionService(), authProvider.user),
        ),
      ],
      child: MaterialApp(
        title: 'Urban Farming',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.user == null) {
              return LoginScreen();
            }
            return MainScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}