import 'package:camera/camera.dart';

abstract class InteractiveImageEvent {}

class NewImage extends InteractiveImageEvent {
  NewImage({
    required this.image,
    required this.angle,
  });
  final XFile image;
  final double angle;
}