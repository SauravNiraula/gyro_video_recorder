import 'package:camera/camera.dart';

abstract class CameraState {}

class CameraAvailable extends CameraState {
  final List<CameraDescription> cameras;

  CameraAvailable({
    required this.cameras,
  });
}

class BackCameraControllerAvailable extends CameraState {
  final CameraController controller;

  BackCameraControllerAvailable({
    required this.controller,
  });
}

class CameraEmpty extends CameraState{}
class CameraLoading extends CameraState {}