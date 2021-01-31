import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/list'),
              child: Text('Show List'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/form'),
              child: Text('Add New'),
            ),
          ],
        ),
      ),
    );
  }
}
