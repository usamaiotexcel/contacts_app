import 'package:contacts_app/features/contacts/data/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/contacts/screens/home_screen.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
   WidgetsFlutterBinding.ensureInitialized();

  print("Platform: ${Platform.operatingSystem}");

  if (!Platform.isAndroid && !Platform.isIOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const ContactsApp());
}

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MaterialApp(
        title: 'Contacts App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
