import 'package:flutter/material.dart';

import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_inspector/pages/home.dart';
import 'package:morpheus_inspector/shared_prefs.dart';
import 'package:morpheus_inspector/view_model_provider.dart';
import 'package:morpheus_sdk/utils.dart';

void main() {
  Log log = Log(InspectorApp);
  WidgetsFlutterBinding.ensureInitialized();
  AppSharedPrefs.setValidatorUrl(TestUrls.gcpValidator);
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
