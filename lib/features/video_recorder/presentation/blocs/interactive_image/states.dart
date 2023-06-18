
abstract class InteractiveImageState {}

class InteractiveImageEmpty extends InteractiveImageState {}

class LastAngles extends InteractiveImageState {
  double angle;

  LastAngles({
    required this.angle,
  });
}