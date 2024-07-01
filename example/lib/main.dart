import 'package:cupertino_hebrew_date_picker/cupertino_hebrew_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:kosher_dart/kosher_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hebrew Date Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                'sleected ata: - ${HebrewDateFormatter().format(JewishDate.fromDateTime(selectedDate))}'),
            TextButton(
              onPressed: () {
                showHebrewCupertinoDatePicker(
                    confirmText: "Confirm",
                    initialDate: DateTime.now(),
                    context: context,
                    // Everytime the date is changed, the callback is called
                    onDateChanged: (dateTime) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                    },
                    // When the users clicks on the confirm button, the onConfirm callback is called.
                    onConfirm: (dateTime) {
                      print(dateTime);
                    });
              },
              child: const Text("Open picker"),
            ),
          ],
        ),
      ),
    );
  }
}
