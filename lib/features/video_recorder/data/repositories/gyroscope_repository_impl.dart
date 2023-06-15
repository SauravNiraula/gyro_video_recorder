import 'package:gyro_video_recorder/core/errors/exceptions.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/entities/gyroscope.dart';
import 'package:gyro_video_recorder/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/repositories/gyroscope_repository_contract.dart';

import '../datasources/gyroscope_data_source.dart';

class GyroscopeRepository implements GyroscopeRepositoryContract {
  GyroscopeRepository({
    required this.gyroDataSource,
  });

  final GyroscopeDataSource gyroDataSource;

  @override
  Either<Failure, Stream<Gyroscope>> getGyroscopeData() {
    try {
      return Right(gyroDataSource.getGyroscopeStream());
    }
    on Expection {
      return Left(Failure());
    }
  }
}