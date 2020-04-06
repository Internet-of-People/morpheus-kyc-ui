import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morpheus_common/utils/schema_form/photo_selector_controller.dart';

// TODO:
// - https://medium.com/saugo360/creating-custom-form-fields-in-flutter-85a8f46c2f41
// - https://stackoverflow.com/questions/54848639/flutter-custom-formfield-validate-and-save-methods-are-not-called

class PhotoSelectorFormField extends FormField<File> {
  final PhotoSelectorController controller;
  final String title;

  PhotoSelectorFormField({
    this.controller,
    this.title,
    FormFieldSetter<File> onSaved,
    FormFieldValidator<File> validator,
    String initialValue,
    bool autovalidate = false,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: controller?.image ?? initialValue,
    autovalidate: autovalidate,
    builder: (FormFieldState<File> state) {
      final subheadTheme = Theme.of(state.context).textTheme.subtitle1;
      final titleColor = state.hasError ? Colors.red : subheadTheme.color;
      final titleStyle = subheadTheme.copyWith(color: titleColor);

      final content = <Widget>[
        Row(children: <Widget>[
          Expanded(child: Text(title, style: titleStyle)),
        ]),
      ];

      if (controller.isImageSelected()) {
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: Image.file(controller.image),
        ));
      } else {
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: Row(children: <Widget>[
            Expanded(child: Text('Click Here to Select a Photo')),
          ]),
        ));
      }

      if (state.hasError) {
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0, 16.0, 0.0, 0.0),
          child: Row(children: <Widget>[
            Expanded(child: Text(state.errorText, style: TextStyle(color: Colors.red),))
          ],),
        ));
      }

      return InkWell(
          onTap: () async {
            final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
            final image = await decodeImageFromList(imageFile.readAsBytesSync());
            final scale = _calcScale(image.width, image.height, 512, 512);
            final compressedFile = await FlutterImageCompress.compressAndGetFile(
              imageFile.path,
              imageFile.path.replaceFirst('.jpg','_compressed.jpg'),
              minWidth: image.width~/scale,
              minHeight: image.height~/scale,
              quality: 80,
            );
            state.didChange(compressedFile);
            controller.image = compressedFile;
            await imageFile.delete();
          },
          child: Card(child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                  children: content
              )
          ))
      );
    }
  );

  static int _calcScale(
    int srcWidth,
    int srcHeight,
    int minWidth,
    int minHeight,
  ) {
    final scaleW = srcWidth ~/ minWidth;
    final scaleH = srcHeight ~/ minHeight;

    return math.max(1, math.min(scaleW, scaleH));
  }
}