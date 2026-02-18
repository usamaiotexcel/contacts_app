import 'package:contacts_app/features/contacts/data/db_helper.dart';
import 'package:contacts_app/features/contacts/models/contacts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ContactProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  final List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  List<Contact> get favorites => _contacts.where((c) => c.isFavorite).toList();

  void addContact(String name, String phone, String email) async {
    final newContact = Contact(
   id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      email: email,
    );

    _contacts.add(newContact);
      await DBHelper.insert(newContact);
    notifyListeners();
  }

  void deleteContact(String id) async{
    _contacts.removeWhere((c) => c.id == id);
    await DBHelper.delete(id);

    notifyListeners();
  }

void toggleFavorite(String id) async {
    final contact = _contacts.firstWhere((c) => c.id == id);
    contact.isFavorite = !contact.isFavorite;

    await DBHelper.update(contact);

    notifyListeners();
  }


  void updateContact(String id, String name, String phone, String email) async {
    final contact = _contacts.firstWhere((c) => c.id == id);

    contact.name = name;
    contact.phone = phone;
    contact.email = email;

    await DBHelper.update(contact);
    notifyListeners();
  }


  ContactProvider() {
    loadContacts();
  }

Future loadContacts() async {
    _contacts.clear();
    _contacts.addAll(await DBHelper.getContacts());
    _isLoading = false;
    notifyListeners();
  }

}
