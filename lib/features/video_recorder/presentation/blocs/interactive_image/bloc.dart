import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyro_video_recorder/features/video_recorder/domain/entities/interactive_image.dart';
import 'package:gyro_video_recorder/features/video_recorder/presentation/blocs/interactive_image/events.dart';
import 'package:gyro_video_recorder/features/video_recorder/presentation/blocs/interactive_image/states.dart';

const double angleIncrement = 0.1;

class InteractiveImageBloc
    extends Bloc<InteractiveImageEvent, InteractiveImageState> {
  final InteractiveImageData interactiveImageData =
      InteractiveImageData(images: []);
  final LastAngles newAngles = LastAngles(
    angle: 0,
  );

  InteractiveImageBloc() : super(InteractiveImageEmpty()) {
    on<NewImage>(_gotNewImage);
  }

  void _addAndEmit(NewImage event, Emitter<InteractiveImageState> emit) {
    interactiveImageData.images.add(
      ImageWithAngle(
        angle: event.angle,
        image: event.image,
      ),
    );
    newAngles.angle += angleIncrement;
    emit(newAngles);
  }

  void _gotNewImage(
    InteractiveImageEvent event,
    Emitter<InteractiveImageState> emit,
  ) {
    if (event is NewImage) {
      if (interactiveImageData.images.isEmpty) {
        _addAndEmit(event, emit);
      } else if (newAngles.angle == event.angle) {
        _addAndEmit(event, emit);
      }
    }
  }
}
