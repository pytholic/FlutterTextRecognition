## Adding device resource access keys
To acces device *camera* or *gallery*, add the following `keys` in `ios/Runner/Info.plist`
```plist
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo Library Access Warning</string>
```

## Issues
### Text not read properly on iOS
Apparently iOS image needs to be rotated somehow to be for proper recognition of text. I used flutter_exif_rotation package for that.
* Add the package in your `pubspec.yaml` file
```yaml
flutter_exif_rotation: ^0.3.2
```
* Import the package as follows
```dart
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
```
* Usage in my case
```dart
Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    if (Platform.isIOS) {
      File rotatedImage =
          await FlutterExifRotation.rotateImage(path: file.path);
      setImage(File(rotatedImage.path));
    } else {
      setImage(File(file.path));
    }
  }
```
