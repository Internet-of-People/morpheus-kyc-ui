import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morpheus_kyc_user/utils/schema_form/photo_selector_controller.dart';

// TODO:
// - https://medium.com/saugo360/creating-custom-form-fields-in-flutter-85a8f46c2f41
// - https://stackoverflow.com/questions/54848639/flutter-custom-formfield-validate-and-save-methods-are-not-called

class PhotoSelectorFormField extends FormField<String> {
  PhotoSelectorFormField({
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    String initialValue,
    bool autovalidate = false,
    String title,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autovalidate,
    builder: (FormFieldState<String> state) {
      // TBD
    }
  );
}

class PhotoSelector extends StatefulWidget {
  final String _title;
  final FormFieldValidator _validator; // TODO
  final PhotoSelectorController _controller;

  const PhotoSelector(this._title, this._validator, this._controller, {Key key}) : super(key: key);

  PhotoSelectorController get controller => _controller;

  @override
  State<StatefulWidget> createState() {
    return PhotoSelectorState();
  }
}

class PhotoSelectorState extends State<PhotoSelector> {
  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      Row(children: <Widget>[
        Expanded(child: Text(widget._title, style: Theme.of(context).textTheme.subhead,))
      ])
    ];

    if(widget._controller.isImageSelected()){
      content.add(Container(
        margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: Image.file(widget._controller.image),
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

    return InkWell(
      onTap: _onDateTapped,
      child: Card(child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: content
        )
      ))
    );
  }

  void _onDateTapped() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      widget._controller.image = image;
    });
  }
}