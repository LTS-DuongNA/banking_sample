// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../utils/observable_serivce.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';

import '../viewmodels/home_viewmodel.dart';

class ExampleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleListState();
}

class _ExampleListState extends State<ExampleList> {
  static final List<String> _exampleWidgetNames = <String>[];
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(File(_homeViewModel.imgFront!.path));
      final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();
      final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(File(_homeViewModel.imgFront!.path));

      final VisionText visionText = await textRecognizer.processImage(visionImage);
      String? text = visionText.text;

      _homeViewModel.textsRecognizedFromIng = "";

      for (TextBlock block in visionText.blocks) {
        final String? text = block.text;

        _homeViewModel.textsRecognizedFromIng += "$text";

        // for (TextLine line in block.lines) {
        //   // Same getters as TextBlock
        //   for (TextElement element in line.elements) {
        //     // Same getters as TextBlock
        //   }
        // }
      }

      print("fawef ${_homeViewModel.textsRecognizedFromIng}");

      _homeViewModel.analyzeText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example List'),
      ),
      body: ListView.builder(
        itemCount: _exampleWidgetNames.length,
        itemBuilder: (BuildContext context, int index) {
          final String widgetName = _exampleWidgetNames[index];

          return Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              title: Text(widgetName),
              onTap: () => Navigator.pushNamed(context, '/$widgetName'),
            ),
          );
        },
      ),
    );
  }
}