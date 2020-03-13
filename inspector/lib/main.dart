import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/validator_api.dart';

import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_inspector/pages/home.dart';
import 'package:morpheus_inspector/view_model_provider.dart';

void main() {
  Log log = Log(InspectorApp);
  WidgetsFlutterBinding.ensureInitialized();
  ValidatorApi.setAsEmulator();
  () async {
    log.debug(('Bootstrapping application...'));
    runApp(InspectorApp());
  }();
}

class InspectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModel(
        child: MaterialApp(
          title: 'Inspector App',
          theme: MorpheusTheme.theme,
          home: HomePage(),
        ),
    );
  }
}
