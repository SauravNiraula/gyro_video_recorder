import 'package:gyro_video_recorder/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:gyro_video_recorder/core/usecases/usecase.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/repositories/gyroscope_repository_contract.dart';

import '../entities/gyroscope.dart';

class GetGyroscopeData implements UseCase<Stream<Gyroscope>, NoParams> {
  GetGyroscopeData(this.gyroscopeRepository);

  final GyroscopeRepositoryContract gyroscopeRepository;

  @override
  Either<Failure, Stream<Gyroscope>> call(NoParams params) {
    return gyroscopeRepository.getGyroscopeData();
  }
}