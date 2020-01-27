import 'dart:convert';
import 'dart:io';

class PhotoSelectorController {
  File image;

  bool isImageSelected() => image != null;

  String imageAsString() {
    if(image == null) {
      return null;
    }

    return base64Encode(image.readAsBytesSync());
  }
}