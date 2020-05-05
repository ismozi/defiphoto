import 'dart:io';
    import 'package:path/path.dart';
    import 'package:sqflite/sqflite.dart';
    import 'package:path_provider/path_provider.dart';

    // database table and column names
    final String questions = 'questions';
    final String columnId = '_id';
    final String columnText = 'text';
    final String columnType = 'type';
    final String columnSender = 'sender';

    // data model class
    class Question{

      String id;
      String text;
      String type;
      String sender;

      Question();

      // convenience constructor to create a Word object
      Question.fromMap(Map<String, dynamic> map) {
        id = map[columnId];
        text = map[columnText];
        type = map[columnType];
        sender = map[columnSender];
      }

      // convenience method to create a Map from this Word object
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

    // singleton class to manage the database
    class DatabaseHelper {

      // This is the actual database filename that is saved in the docs directory.
      static final _databaseName = "MyDatabase.db";
      // Increment this version when you need to change the schema.
      static final _databaseVersion = 1;

      // Make this a singleton class.
      DatabaseHelper._privateConstructor();
      static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

      // Only allow a single open connection to the database.
      static Database _database;
      Future<Database> get database async {
        if (_database != null) return _database;
        _database = await _initDatabase();
        return _database;
      }

      // open the database
      _initDatabase() async {
        // The path_provider plugin gets the right directory for Android or iOS.
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        // Open the database. Can also add an onUpdate callback parameter.
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: _onCreate);
      }

      // SQL string to create the database 
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

      // Database helper methods:

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

      // TODO: queryAllWords()
      // TODO: delete(int id)
      // TODO: update(Word word)
    }