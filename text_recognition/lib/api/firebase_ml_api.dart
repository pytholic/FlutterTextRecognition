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

  static extractText(VisionText visionText) {
    String text = '';

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        //var tmp_line = '';
        //for (TextElement word in line.elements) {
        //tmp_line += word.text + ' ';
        // var text_tmp = '';
        // for (TextElement word in line.elements) {
        //   text_tmp += word.text;
        //}
        text = text + line.text + '\n';
        //text = text + tmp_line + '\n';
        //}
        //var tmp = line.toString();
        //text = text + line.text + '\n';
      }
    }

    return text;
  }
}
