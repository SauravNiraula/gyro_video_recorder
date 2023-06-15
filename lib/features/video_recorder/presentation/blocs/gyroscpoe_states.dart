import '../../domain/entities/gyroscope.dart';

abstract class GyroscopeState {}

class GyroscopeErrorState extends GyroscopeState {
  final Error error;
  GyroscopeErrorState({required this.error});
}

class GyroscopeAnglesAvailable extends GyroscopeState {
  final Stream<GyroscopeAngles> stream;
  GyroscopeAnglesAvailable({required this.stream});
}

class Empty extends GyroscopeState {}