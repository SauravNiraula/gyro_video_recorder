import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gyro_video_recorder/core/errors/failures.dart';
import 'package:gyro_video_recorder/core/usecases/usecase.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/entities/gyroscope.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/repositories/gyroscope_repository_contract.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/usecases/get_gyroscope_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_gyroscope_data_test.mocks.dart';

@GenerateMocks([GyroscopeRepositoryContract])

void main() {
  late GyroscopeRepositoryContract gyroRepo;
  late GetGyroscopeData usecase;

  setUp(() {
    gyroRepo = MockGyroscopeRepositoryContract();
    usecase = GetGyroscopeData(gyroRepo);
  });

  test("test usecase using mocked repo", () async{

    when(gyroRepo.getGyroscopeData()).thenAnswer((_) {
      final stream = Stream.periodic(
        const Duration(seconds: 1),
        (_) => const Gyroscope(x: 1, y: 2, z: 2)
      );
      return Right(stream);
    });

    final stream = usecase(NoParams());
    final gyroData = await stream.foldRight(Future.value(const Gyroscope(x: 0, y: 0, z: 0)), (newData, oldData) async{
      return await newData.first;
    });

    expect(gyroData.x, 1);
    expect(stream.runtimeType, Right<Failure, Stream<Gyroscope>>);
    verify(gyroRepo.getGyroscopeData());

  });
}