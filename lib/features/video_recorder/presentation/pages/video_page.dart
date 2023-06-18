import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/bloc.dart';

final sl = GetIt.instance;

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<GyroscopeBloc>()),
        BlocProvider(create: (context) => sl<InteractiveImageBloc>()),
        BlocProvider(
          create: (context) => sl<CameraBloc>()..add(GetBackCameraController()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<CameraBloc, CameraState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case CameraEmpty:
                return const Center(
                  child: Text('Loading camera'),
                );
              case BackCameraControllerAvailable:
                state as BackCameraControllerAvailable;
                return Stack(
                  children: [
                    Center(child: CameraPreview(state.controller)),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(131, 0, 0, 0),
                        ),
                      ),
                    ),
                    Center(
                      child: BlocBuilder<InteractiveImageBloc, InteractiveImageState>(
                        builder: (context, snapshot) {
                          if(snapshot is LastAngles) {
                            print(snapshot.angle);
                            return Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(61, 0, 47, 255),
                              ),
                            );
                          }
                          return const SizedBox();
                        }
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      right: 30,
                      child: GestureDetector(
                        onTap: () async{
                          final image = await state.controller.takePicture();
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<InteractiveImageBloc>(context).add(NewImage(image: image, angle: 0));
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<GyroscopeBloc>(context).add(GetGyroscopeStream());
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Icon(Icons.camera),),
                      ),
                    ),
                  ],
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
