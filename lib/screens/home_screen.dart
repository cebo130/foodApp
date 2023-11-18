import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'nothing yet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          GestureDetector(
            child: Container(
              height: 40,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.lightBlue,
              ),
              child: Center(
                child: Text('Press me'),
              ),
            ),
            onTap: ()async{
              // ///OPen Database
              // Database database = await openDatabase(
              //   'my_db.db',version: 1,
              //   onCreate: (Database db, int version)async{
              //     await  db.execute(
              //       'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'
              //     );
              //   }
              // );
              // ///Insert into Database
              // int id1 = await database.rawInsert(
              //   'INSERT INTO Test(name,value,num) VALUES("Ryza",1234,456.789)'
              // );
              // ///Retrieve from database
              // List<Map> list =await database.rawQuery('SELECT * FROM Test');
              // print("my list is : $list");
              // await database.close();
              final externalDir = await getExternalStorageDirectory();
              final appDir = Directory('${externalDir!.path}/MyApp');
              await appDir.create(recursive: true);
              final dbPath = join(appDir.path, 'my_db.db');
              Database database = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
                db.execute( 'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
              });
              int id1 = await database.rawInsert(
                 'INSERT INTO Test(name,value,num) VALUES("Ryza",1234,456.789)'
               );
              ///Retrieve from database
              List<Map> list =await database.rawQuery('SELECT * FROM Test');
              print("my list is : $list");
              await database.close();
            },
          ),
          SizedBox(height: 20,),
          Text(name),
        ],
      ),
    );
  }
}
