import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/gyroscope.dart';

abstract class GyroscopeRepositoryContract {
  Either<Failure, Stream<Gyroscope>> getGyroscopeData();
}