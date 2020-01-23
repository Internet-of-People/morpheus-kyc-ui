import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/pages/sign_request/sign_request.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CreateEvidenceDataPage extends StatefulWidget {
  final String _processName;
  final JsonSchema _evidenceSchema; // TODO

  const CreateEvidenceDataPage(this._processName, this._evidenceSchema, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateEvidenceDataPageState();
  }
}

class CreateEvidenceDataPageState extends State<CreateEvidenceDataPage> {
  CameraController _controller;
  Future<void> _initCameraFuture;

  @override
  void initState() {
    super.initState();
    _initCameraFuture = initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSavePressed(context, path) async {
    final file = File(path);
    print(base64Encode(await file.readAsBytes()));
    await file.delete();

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => SignRequestPage(widget._processName)
    ));
  }

  void onTryAgainPressed(context, path) async {
    await File(path).delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._processName),
      ),
      body: FutureBuilder(
        future: _initCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initCameraFuture;
            final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
            await _controller.takePicture(path);

            showModalBottomSheet(context: context, builder: (context){
              return Column(
                children: <Widget>[
                  Image.file(File(path)),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () => onSavePressed(context, path),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => onTryAgainPressed(context, path),
                      ),
                    ],
                  )
                ],
              );
            });
          }
          catch(e) {
            print(e);
          }
        },
      ),
    );
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
  }
}