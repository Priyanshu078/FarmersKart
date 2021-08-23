import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio.aac';

class SoundRecorder1 {
  FlutterSoundRecorder _audioRecorder;
  bool _isRecorderInitialised = false;
  bool get isRecording => _audioRecorder.isRecording;
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permissoin');
    }
    await _audioRecorder.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    _audioRecorder.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    await _audioRecorder.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
