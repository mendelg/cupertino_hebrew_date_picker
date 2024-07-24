
A Flutter plugin for showing a Cupertino-styled Hebrew date picker. And returns a `DateTime` object.

For a _Material_ Hebrew date picker See [`material_hebrew_date_picker`](https://pub.dev/packages/material_hebrew_date_picker).


## Features
![Image of the package](./screenshots/1.png?raw=true "Optional Title")



## Usage

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            showHebrewCupertinoDatePicker(
                confirmText: "Confirm",
                context: context,

                onDateChanged: (dateTime) {
                  print(dateTime);
                },
                // When the user click on the "Confirm" button, the onConfirm callback is called.
                onConfirm: (dateTime) {
                  print(dateTime);
                });
          },
          child: const Text("open picker"),
        ),
      ),
    );
  }
}
```

You can also an specify an initial date date to the picker. as well as `confirmTextStyle` and  `cancelTextStyle`

```none
 showHebrewCupertinoDatePicker(
       
        initialDate: DateTime.now(),
        confirmTextStyle: TextStyle(
        color: CupertinoColors.destructiveRed,
        fontWeight: FontWeight.w600,
        ),
        context: context,
        onDateChanged: (dateTime) {
        print(dateTime);
        },
    
        onConfirm: (dateTime) {
        print(dateTime);
        }
 );
```

A Hebrew Calendar / Hebrew Date picker 
