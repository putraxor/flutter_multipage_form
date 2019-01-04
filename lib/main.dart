import 'package:flutter/material.dart';
import 'package:flutter_multipage_form/multi_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xFF1DCC8C),
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiForm(),
    );
  }
}
