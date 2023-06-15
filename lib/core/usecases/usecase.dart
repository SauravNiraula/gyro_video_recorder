import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams {}