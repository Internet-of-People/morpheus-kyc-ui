import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morpheus_kyc_user/utils/schema_form/photo_selector_controller.dart';

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
    initialValue: controller != null ? controller.image : (initialValue ?? null),
    autovalidate: autovalidate,
    builder: (FormFieldState<File> state) {
      final subheadTheme = Theme.of(state.context).textTheme.subhead;
      final titleColor = state.hasError ? Colors.red : subheadTheme.color;
      final titleStyle = subheadTheme.copyWith(color: titleColor);

      List<Widget> content = [
        Row(children: <Widget>[
          Expanded(child: Text(title, style: titleStyle))
        ])
      ];

      if(controller.isImageSelected()){
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: Image.file(controller.image),
        ));
      }
      else {
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: Row(children: <Widget>[
            Expanded(child: Text('Click Here to Select a Photo'))
          ]),
        ));
      }

      if(state.hasError) {
        content.add(Container(
          margin: EdgeInsets.fromLTRB(0, 16.0, 0.0, 0.0),
          child: Row(children: <Widget>[
            Expanded(child: Text(state.errorText, style: TextStyle(color: Colors.red),))
          ],),
        ));
      }

      return InkWell(
          onTap: () async {
            final image = await ImagePicker.pickImage(source: ImageSource.camera);
            state.didChange(image);
            controller.image = image;
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
}