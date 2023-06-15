import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyro_video_recorder/features/video_recorder/presentation/blocs/bloc.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  List<CameraDescription>? _availableCameras;
  CameraController? _controller;

  CameraBloc() : super(CameraEmpty()) {
    on<GetAvailableCameras>(_getAvailableCameras);
    on<GetBackCameraController>(_getBackCameraController);
  }

  @override
  Future<void> close() async {
    _controller!.dispose();
    return super.close();
  }

  Future<void> _fetchCameras() async {
    _availableCameras ??= await availableCameras();
  }

  void _getBackCameraController(CameraEvent event, Emitter<CameraState> emit) async{
    if (_controller == null) {
      await _fetchCameras();
      _controller = CameraController(
        _availableCameras![0],
        ResolutionPreset.max,
      );
      await _controller!.initialize();
    }
    emit(
      BackCameraControllerAvailable(
        controller: _controller!,
      ),
    );
  }

  void _getAvailableCameras(
    CameraEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());
    await _fetchCameras();
    emit(
      CameraAvailable(
        cameras: _availableCameras!,
      ),
    );
  }
}
