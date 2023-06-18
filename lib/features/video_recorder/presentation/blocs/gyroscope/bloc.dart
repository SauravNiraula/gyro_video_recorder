import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/entities/gyroscope.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/usecases/get_gyroscope_data.dart';

import '../../../../../core/usecases/usecase.dart';
import '../bloc.dart';

const double angleFix = 5.806451;

class GyroscopeBloc extends Bloc<GyroscopeEvent, GyroscopeState> {
  final GetGyroscopeData getGyroscopeData;
  late GyroscopeAngles angles;
  late GyroscopeVelocities velocities;

  GyroscopeBloc({
    required this.getGyroscopeData,
  }) : super(Empty()) {
    on<GetGyroscopeStream>(_onGyroscopeStream);
    on<ResetGyroscopeStream>(_resetGyroscopeData);
    _resetData();
  }

  void _resetData() {
    velocities = const GyroscopeVelocities(roll: 0, pitch: 0, yaw: 0);
  }

  void _resetGyroscopeData(GyroscopeEvent event, Emitter<GyroscopeState> emit) {
    _resetData();
  }

  void _onGyroscopeStream(GyroscopeEvent event, Emitter<GyroscopeState> emit) {
    getGyroscopeData(NoParams()).fold(
      (l) => emit(
        GyroscopeErrorState(
          error: Error(),
        ),
      ),
      (r) {
        final velStream = r.map(
          (gyroData) {
            velocities = GyroscopeVelocities(
              roll: velocities.roll + gyroData.z,
              pitch: velocities.pitch + gyroData.x,
              yaw: velocities.yaw + gyroData.y,
            );
            return velocities;
          },
        );
        final angStream = velStream.map(
          (velocity) {
            return GyroscopeAngles(
              roll: (velocities.roll + velocity.roll) * angleFix,
              pitch: (velocities.pitch + velocity.pitch) * angleFix,
              yaw: (velocities.yaw + velocity.yaw) * angleFix,
            );
          },
        );
        emit(
          GyroscopeAnglesAvailable(stream: angStream),
        );
      },
    );
  }
}
