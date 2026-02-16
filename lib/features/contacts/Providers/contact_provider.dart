import 'package:contacts_app/features/contacts/models/contacts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  List<Contact> get favorites => _contacts.where((c) => c.isFavorite).toList();

  void addContact(String name, String phone, String email) {
    final newContact = Contact(
      id: Random().nextInt(999999).toString(),
      name: name,
      phone: phone,
      email: email,
    );

    _contacts.add(newContact);
    notifyListeners();
  }

  void deleteContact(String id) {
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final contact = _contacts.firstWhere((c) => c.id == id);
    contact.isFavorite = !contact.isFavorite;
    notifyListeners();
  }

  void updateContact(String id, String name, String phone, String email) {
    final contact = _contacts.firstWhere((c) => c.id == id);
    contact.name = name;
    contact.phone = phone;
    contact.email = email;
    notifyListeners();
  }
}
