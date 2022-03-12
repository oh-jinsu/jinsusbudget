import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  static String get databaseName => dotenv.env["DATABASE_NAME"]!;

  static int get databaseVersion => int.parse(dotenv.env["DATABASE_VERSION"]!);
}
