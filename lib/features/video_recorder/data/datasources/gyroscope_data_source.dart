import 'package:sensors_plus/sensors_plus.dart';

import '../models/gyroscope_model.dart';

class GyroscopeDataSource {
  Stream<GyroscopeModel> getGyroscopeStream() {
    return gyroscopeEvents.map<GyroscopeModel>((event) {
      return GyroscopeModel(x: event.x, y: event.y, z: event.z);
    });
  }
}
