import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zendesk/zendesk.dart';

void main() => runApp(new MyApp());

const ZendeskAccountKey = 'VDKJ4ZBcrMu3cXaTcuGSnCZT2jKvLzrY';
final String appId = 'e97dc25bf9d6481c6734b3a9fb8bc2cf369065b98c6c1b61';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Zendesk zendesk = Zendesk();

  @override
  void initState() {
    super.initState();
    initZendesk();
  }

  // Zendesk is asynchronous, so we initialize in an async method.
  Future<void> initZendesk() async {
    zendesk.init(ZendeskAccountKey, appId: appId).then((r) {
      print('init finished');
    }).catchError((e) {
      print('failed with error $e');
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // But we aren't calling setState, so the above point is rather moot now.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RawMaterialButton(
                fillColor: Colors.blueAccent,
                child: Text('Start Chat'),
                onPressed: () async {
                  zendesk
                      .setVisitorInfo(
                          name: 'My Name',
                          email: 'dasdsadasd',
                          phoneNumber: '323-555-1212')
                      .then((r) {
                    print('setVisitorInfo finished');
                  }).catchError((e) {
                    print('error $e');
                  });
                  zendesk.startChat().then((r) {
                    print('startChat finished');
                  }).catchError((e) {
                    print('error $e');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
