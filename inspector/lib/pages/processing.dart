import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:redux/redux.dart';

abstract class _Step {
  static const int downloading = 0;
  static const int verifyingSignatures = 1;
  static const int inspecting = 2;
}

class Processing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProcessingState();
  }
}

class ProcessingState extends State<Processing> {
  final GlobalKey key = GlobalKey(debugLabel: 'Processing');

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: _urlConverter,
      builder: (context, url) =>  StoreConnector<AppState, int>(
        converter: _stepConverter,
        builder: (context, step) => Scaffold(
          appBar: AppBar(
            title: Text('Processing URL'),
          ),
          body: Column(
            children: <Widget>[
              Text(url),
              Stepper(
                currentStep: step,
                controlsBuilder: _buildStepperControls,
                steps: [
                  Step(
                    title: const Text('Downloading'),
                    isActive: step == _Step.downloading,
                    content: LinearProgressIndicator(),
                  ),
                  Step(
                    title: const Text('Verifying signatures'),
                    isActive: step == _Step.verifyingSignatures,
                    content: LinearProgressIndicator(),
                  ),
                  Step(
                    title: const Text('Inspecting claim'),
                    isActive: step == _Step.inspecting,
                    content: LinearProgressIndicator(),
                  )
                ],
              )
            ],
          ) )
    ) );
  }

  Widget _buildStepperControls(BuildContext context,
      { onStepCancel, onStepContinue }) {
    return Container();
  }

  int _stepConverter(Store<AppState> store) {
    var state = store.state;
    assert(state.url != null);

    if (state.presentationJson == null) {
      return _Step.downloading;
    }

    if (state.signatureErrors == null) {
      return _Step.verifyingSignatures;
    }

    assert(state.discount == null);
    return _Step.inspecting;
  }

  String _urlConverter(Store<AppState> store) {
    return store.state.url;
  }
}
