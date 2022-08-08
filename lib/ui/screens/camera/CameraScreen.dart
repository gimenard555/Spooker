import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../gen/assets.gen.dart';

typedef PhotoTaken = void Function(XFile);

// ignore: must_be_immutable
class CameraScreen extends HookConsumerWidget {
  CameraScreen(this._camera, this._takenPhoto);

  final CameraDescription _camera;
  final PhotoTaken _takenPhoto;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaSize = MediaQuery.of(context).size;
    initCamera(_camera);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Transform.scale(
                    scale: 1 /
                        (_controller.value.aspectRatio * mediaSize.aspectRatio),
                    alignment: Alignment.center,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            InkWell(
              onTap: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  _takenPhoto(image);
                  Navigator.pop(context);
                } catch (e) {}
              },
              child: Container(
                margin: EdgeInsets.all(SpookerSize.m20),
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: [
                    Assets.images.takePhoto.image(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }
}
