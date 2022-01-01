import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class FirebaseMLApi {
  static Future<String> recogniseText(File? imageFile) async {
    if (imageFile == null) {
      return 'No image selected';
    } else {
      final visionImage = FirebaseVisionImage.fromFile(imageFile);
      final textRecognizer = FirebaseVision.instance.textRecognizer();

      try {
        final visionText = await textRecognizer.processImage(visionImage);
        await textRecognizer.close();

        final text = extractText(visionText);
        return text.isEmpty ? 'No text found in the image' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }

  // Function to excludes prices
  static bool isNumeric(String string) {
    final numericRegex = RegExp(r'^-?(([0-9,]*)|(([0-9,]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  static extractText(VisionText visionText) {
    String text = '';

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        String tmp = '';
        for (TextElement word in line.elements) {
          // Excluding prices (digits)
          if (isNumeric(word.text)) {
            tmp = '';
          } else {
            tmp += word.text;
          }
        }
        if (tmp == '') {
          text = text;
        } else {
          text = text + tmp + '\n';
        }
      }
    }

    return text;
  }
}
