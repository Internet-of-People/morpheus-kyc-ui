import 'package:flutter/material.dart';
import 'package:morpheus_sdk/crypto.dart';

class KeySelectorValue {
  final int keyIndex;
  final String key;

  KeySelectorValue(this.keyIndex, this.key);
}

class KeySelectorController extends ValueNotifier<KeySelectorValue> {
  KeySelectorController({KeySelectorValue value}) : super(value);
}

class KeySelector extends StatefulWidget {
  final KeySelectorController _controller;
  final CryptoAPI _cryptoAPI;

  const KeySelector(this._controller, this._cryptoAPI, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeySelectorState();
}

class _KeySelectorState extends State<KeySelector> {
  List<String> _availableKeys;
  String _selectedKey;
  int _selectedKeyIndex;

  @override
  void initState() {
    super.initState();

    // TODO: show only keys that has rights to sign
    _availableKeys = widget._cryptoAPI.getDocument(widget._cryptoAPI.listDids()[0]).keys.map((key) => key.auth).toList();
    _selectedKeyIndex = 0;
    _selectedKey = _availableKeys[_selectedKeyIndex];
    widget._controller.value = KeySelectorValue(
      _selectedKeyIndex,
      _selectedKey
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: [
          Expanded(child: Text(
            'Please select, which key you would like to use for signing:',
          ))
        ]),
        DropdownButton<String>(
          value: _selectedKey,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black),
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          onChanged: (String newValue) {
            setState(() {
              _selectedKeyIndex = _availableKeys.indexOf(newValue);
              _selectedKey = _availableKeys[_selectedKeyIndex];
              widget._controller.value = KeySelectorValue(
                _selectedKeyIndex,
                _selectedKey
              );
            });
          },
          items: _availableKeys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      ],
    );
  }
}