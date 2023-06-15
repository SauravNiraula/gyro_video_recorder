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
        BlocProvider(
            create: (context) =>
                sl<CameraBloc>()..add(GetBackCameraController())),
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
                state = state as BackCameraControllerAvailable;
                return Stack(
                  children: [
                    Center(child: CameraPreview(state.controller)),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(131, 0, 0, 0),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(61, 0, 47, 255),
                        ),
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
