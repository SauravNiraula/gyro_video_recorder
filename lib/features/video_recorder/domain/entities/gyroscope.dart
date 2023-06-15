import 'package:equatable/equatable.dart';

class Gyroscope extends Equatable {
  final double x;
  final double y;
  final double z;

  const Gyroscope({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object?> get props => [x, y, z];
}

class GyroscopeAngles extends Equatable {
  final double roll;
  final double pitch;
  final double yaw;

  const GyroscopeAngles({
    required this.roll,
    required this.pitch,
    required this.yaw,
  });

  @override
  List<Object?> get props => [roll, pitch, yaw];
}

class GyroscopeVelocities extends Equatable {
  final double roll;
  final double pitch;
  final double yaw;

  const GyroscopeVelocities({
    required this.roll,
    required this.pitch,
    required this.yaw,
  });

  @override
  List<Object?> get props => [roll, pitch, yaw];
}