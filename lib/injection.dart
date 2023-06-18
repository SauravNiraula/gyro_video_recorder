import 'package:get_it/get_it.dart';
import 'package:gyro_video_recorder/features/video_recorder/data/datasources/gyroscope_data_source.dart';
import 'package:gyro_video_recorder/features/video_recorder/data/repositories/gyroscope_repository_impl.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/repositories/gyroscope_repository_contract.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/usecases/get_gyroscope_data.dart';
import 'package:gyro_video_recorder/features/video_recorder/presentation/blocs/interactive_image/bloc.dart';

import 'features/video_recorder/presentation/blocs/bloc.dart';


void init() {

  final sl = GetIt.instance;


  // blocs
  sl.registerFactory(() => GyroscopeBloc(getGyroscopeData: sl()));
  sl.registerFactory(() => CameraBloc());
  sl.registerFactory(() => InteractiveImageBloc());

  // usecase, repo, datasource
  sl.registerLazySingleton(() => GetGyroscopeData(sl()));
  sl.registerLazySingleton<GyroscopeRepositoryContract>(() => GyroscopeRepository(gyroDataSource: sl()));
  sl.registerLazySingleton(() => GyroscopeDataSource());

}