import 'package:contacts_app/features/contacts/models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), "contacts.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE contacts(
        id TEXT PRIMARY KEY,
        name TEXT,
        phone TEXT,
        email TEXT,
        favorite INTEGER
        )
        ''');
      },
    );
  }

  static Future insert(Contact c) async {
      try {
    final database = await db;
    await database.insert("contacts", {
      "id": c.id,
      "name": c.name,
      "phone": c.phone,
      "email": c.email,
      "favorite": c.isFavorite ? 1 : 0,
    });  } catch (e) {
      debugPrint("DB Insert Error: $e");
    }

  }

  static Future<List<Contact>> getContacts() async {
    final database = await db;
    final data = await database.query("contacts");

    return data
        .map(
          (e) => Contact(
            id: e["id"] as String,
            name: e["name"] as String,
            phone: e["phone"] as String,
            email: e["email"] as String,
            isFavorite: (e["favorite"] as int) == 1,
          ),
        )
        .toList();
  }
  static Future update(Contact c) async {
    final database = await db;

    await database.update(
      "contacts",
      {
        "name": c.name,
        "phone": c.phone,
        "email": c.email,
        "favorite": c.isFavorite ? 1 : 0,
      },
      where: "id=?",
      whereArgs: [c.id],
    );
  }


  static Future delete(String id) async {
    final database = await db;
    await database.delete("contacts", where: "id=?", whereArgs: [id]);
  }
}
