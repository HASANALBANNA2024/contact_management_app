import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/contact_model.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();

  static Database? _database;
  DbHelper._init();


  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB,);
  }

  Future _createDB(Database db, int version) async{
    await db.execute('''
    CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT NOT NULL,
    address TEXT NOT NULL,
    isFavorite INTEGER NOT NULL
    )
    ''');
  }

  /// contact add
   Future<int> insertContact(ContactModel contact)async{
    final db = await instance.database;
    return await db.insert('contacts', contact.toMap());
   }

   ///display (READ Contact)
   Future<List<ContactModel>> getAllContacts() async{
    final db = await instance.database;
    final result = await db.query('contacts', orderBy: 'name ASC');
    return result.map((json)=> ContactModel.fromMap(json)).toList();
   }
   ///contact update (update)
   Future<int> updateContact(ContactModel contact)async{
    final db = await instance.database;
    return await db.update('contacts', contact.toMap(), where: 'id=?', whereArgs: [contact.id]);
   }

   /// contact delete
   Future<int> deleteContact(int id)async{
    final db = await instance.database;
    return await db.delete('contacts', where: 'id=?', whereArgs: [id]);
   }

   /// search quary
  Future<List<ContactModel>> searchContacts(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'contacts',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );
    return result.map((json) => ContactModel.fromMap(json)).toList();
  }

  ///Favorite Contact
   Future<List<ContactModel>> getFavoriteContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts', where: 'isFavorite = ?', whereArgs: [1], orderBy: 'name ASC',);
    return result.map((json)=> ContactModel.fromMap(json)).toList();
   }

   ///database close
   Future Close() async {
    final db = await instance.database;
    db.close();
   }


}