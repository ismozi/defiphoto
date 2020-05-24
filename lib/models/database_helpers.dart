import 'dart:io';
    import 'package:path/path.dart';
    import 'package:sqflite/sqflite.dart';
    import 'package:path_provider/path_provider.dart';

   
    final String questions = 'questions';
    final String columnId = '_id';
    final String columnText = 'text';
    final String columnType = 'type';
    final String columnSender = 'sender';

    
    class Question{

      String id;
      String text;
      String type;
      String sender;

      Question();

     
      Question.fromMap(Map<String, dynamic> map) {
        id = map[columnId];
        text = map[columnText];
        type = map[columnType];
        sender = map[columnSender];
      }

      
      Map<String, dynamic> toMap() {
        var map = <String, dynamic>{
          columnId: id,
          columnText: text,
          columnType: type,
          columnSender: sender
        };
        
        return map;
      }
    }

    
    class DatabaseHelper {

      
      static final _databaseName = "MyDatabase.db";
      
      static final _databaseVersion = 1;

      
      DatabaseHelper._privateConstructor();
      static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

      
      static Database _database;
      Future<Database> get database async {
        if (_database != null) return _database;
        _database = await _initDatabase();
        return _database;
      }

      
      _initDatabase() async {
        
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: _onCreate);
      }

      
      Future _onCreate(Database db, int version) async {
        await db.execute('''
              CREATE TABLE $questions (
                $columnId TEXT NOT NULL,
                $columnText TEXT NOT NULL,
                $columnType TEXT NOT NULL,
                $columnSender TEXT NOT NULL
              )
              ''');
      }

      

      deleteAll() async {
    final db = await database;
    db.delete(questions);
  }

      Future<int> insert(Question question) async {
        Database db = await database;
        int id = await db.insert(questions, question.toMap());
        return id;
      }

      

      Future<Question> queryQuestion(int id) async {
        Database db = await database;
        List<Map> maps = await db.query(questions,
            columns: [columnId, columnText, columnType, columnSender],
            where: '$columnId = ?',
            whereArgs: [id]);
        if (maps.length > 0) {
          return Question.fromMap(maps.first);
        }
        return null;
      }

      Future<List<Map<String, dynamic>>> queryAllRows() async {
      Database db = await instance.database;
      return await db.query(questions);
  }

      
    }