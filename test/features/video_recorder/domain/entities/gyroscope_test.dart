import "package:flutter_test/flutter_test.dart";
import "package:gyro_video_recorder/features/video_recorder/domain/entities/gyroscope.dart";

void main() {
  group('Gyroscope test', () {
    test('Gyroscope class working', () {
      final Gyroscope gyro = Gyroscope(x: 1, y: 2, z: 3);
      expect(gyro.x, 1);
    });

  });

}