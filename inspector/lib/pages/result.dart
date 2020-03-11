import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_inspector/view_model.dart';
import 'package:morpheus_inspector/view_model_provider.dart';

class ResultPage extends StatelessWidget {
  ResultPage({ Key key }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = ViewModel.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: SafeArea(
          child: _loadingPresentation(vm),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _loadingPresentation(AppViewModel vm) {
    return FutureBuilder<SignedPresentation>(
      future: vm.presentation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _loadingValidation(vm);
        } else {
          return ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Downloading presentation'),
            subtitle: Text(vm.url),
          );
        }
      },
    );
  }

  Widget _loadingValidation(AppViewModel vm) {
    return FutureBuilder<ValidationResult>(
      future: vm.validation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: EdgeInsets.all(16),
            color: _color(snapshot.data),
            child: Container(
              color: Theme.of(context).dialogBackgroundColor,
              child: ListView(
                children: snapshot.data.items.map(_buildItem).toList(),
              ),
            ),
          );
        } else {
          return ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Validating presentation'),
            subtitle: Text(vm.url),
          );
        }
      },
    );
  }

  Color _color(ValidationResult result) {
    if (result.hasError) {
      return Colors.redAccent;
    } else if (result.hasWarning) {
      return Colors.orangeAccent;
    } else {
      return Colors.lightGreen;
    }
  }

  Widget _buildItem(ValidationItem item) {
    final leading = item.isError ? Icons.error : Icons.warning;
    return ListTile(
      leading: Icon(leading),
      title: Text(item.text),
      subtitle: Text(item.detail),
    );
  }
}
