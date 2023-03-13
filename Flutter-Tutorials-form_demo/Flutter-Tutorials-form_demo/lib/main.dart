
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Profile App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  late final _hobbiesController = TextEditingController(
    text: json.encode(['']),
  );
  final _editorController = QuillController.basic();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      if (file.existsSync()) {
        final jsonData = json.decode(file.readAsStringSync());
        setState(() {
          _nameController.text = jsonData['name'] ?? '';
          _ageController.text = jsonData['age'] ?? '';
          _genderController.text = jsonData['gender'] ?? '';
          _countryController.text = jsonData['country'] ?? '';
          _hobbiesController.text = jsonData['hobbies'] ?? json.encode(['']);
          _editorController.document =
              Document.fromJson(jsonData['document']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _saveData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      file.writeAsStringSync(json.encode({
        'name': _nameController.text,
        'age': _ageController.text,
        'gender': _genderController.text,
        'country': _countryController.text,
        'hobbies': _hobbiesController.text,
        'document': _editorController.document.toJson(),
      }));
    } catch (e) {
      print(e);
    }
  }

  
