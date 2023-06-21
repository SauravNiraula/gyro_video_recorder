import 'dart:async';

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
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(
    //   const Duration(milliseconds: 100),
    //   (timer) {
    //     print('here');
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  double _getTop(BuildContext context, double height, double angle) {
    final totalEffectiveHeight =  MediaQuery.of(context).size.height - height;
    final centerHeight = totalEffectiveHeight / 2;
    final perDegreeMovement = totalEffectiveHeight / ( 2 * 360 );
    return centerHeight + perDegreeMovement * angle;
  }

  double _getLeft(BuildContext context, double width, double angle) {
    // print(angle);
    final totalEffectiveWidth =  MediaQuery.of(context).size.width - width;
    final centerWidth = totalEffectiveWidth / 2;
    final perDegreeMovement = totalEffectiveWidth / ( 2 * 360 );
    return centerWidth + perDegreeMovement * angle;
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
                      child: BlocBuilder<InteractiveImageBloc,
                          InteractiveImageState>(builder: (context, imState) {
                        if (imState is LastAngles) {
                          return BlocBuilder<GyroscopeBloc, GyroscopeState>(
                              builder: (context, gyroState) {
                            if (gyroState is GyroscopeAnglesAvailable) {
                              return StreamBuilder(
                                stream: gyroState.stream,
                                builder: (context, snapshot) => Stack(
                                  children: [
                                    if(snapshot.hasData)
                                    Positioned(
                                      top: _getTop(context, 150, snapshot.data!.pitch),
                                      left: _getLeft(context, 150, snapshot.data!.yaw),
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(61, 0, 47, 255),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          });
                        }
                        return const SizedBox();
                      }),
                    ),
                    Positioned(
                      bottom: 100,
                      right: 30,
                      child: GestureDetector(
                        onTap: () async {
                          final image = await state.controller.takePicture();
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<InteractiveImageBloc>(context)
                              .add(NewImage(image: image, angle: 0));
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<GyroscopeBloc>(context)
                              .add(GetGyroscopeStream());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Icon(Icons.camera),
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
