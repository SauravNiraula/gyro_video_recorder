import 'package:camera/camera.dart';

class ImageWithAngle {
  final double angle;
  final XFile image;

  ImageWithAngle({
    required this.angle,
    required this.image,
  });
}

class InteractiveImageData{
  InteractiveImageData({
    required this.images,
  });

  List<ImageWithAngle> images;

  double get lastAngle => images.last.angle;
}