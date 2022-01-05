# Text Recognition App
A simple **Text Reocgnition** app created with *Flutter*, *Dart* and *Firebase ML Vision* api.

## Steps
* Clone this repositiory
* Open in `VS Code` or editor of your choice
* Run
```console
flutter clean
flutter pub get
flutter run --release --no-sound-null-safety
```

### Additional Steps
* For `iOS`, you might have to add *development team* in the `Runner` properties.
* Set up a unique *Bundle Identifier*. In my case `com.example` was not working, so I wrote my email in place of it.
* You need to setup Firebase as well for this project. Follow steps from my [Todo List](https://github.com/pytholic/FlutterTodoList) repository to set it up.

## Adding device resource access keys
To acces device *camera* or *gallery*, add the following `keys` in `ios/Runner/Info.plist`
```plist
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo Library Access Warning</string>
```

## Usage
* Take an image using `Take Image` button
* Click on `Scan for Text` to scan the text
* Click `CLear` to clear both text and the image
  
## Issues
### Text not recognized
Add the following in your `podfile`.
```
pod 'Firebase/MLVisionTextModel'
```

Also add 
```
pod 'Firebase/Analytics'
```


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

## Helpful Links
* Johannes Milke
    * [Youtube tutorial[(https://www.youtube.com/watch?v=TNKtGOZRA5o)
    * [Git repo](https://github.com/JohannesMilke/firebase_ml_text_recognition)
