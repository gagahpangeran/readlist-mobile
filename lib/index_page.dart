import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/list');
                },
                child: Text('Show List')),
            TextButton(onPressed: null, child: Text('Add New')),
          ],
        ),
      ),
    );
  }
}
