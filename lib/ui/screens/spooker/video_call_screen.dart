import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../components/outputs/custom_tag_text.dart';
import '../../utils/spooker_fonts.dart';

// ignore: must_be_immutable
class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final ClientRole role;

  const VideoCallScreen(this.channelName, this.role);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCallScreen> {
  bool _joined = false;
  final _users = <int>[];
  bool muted = false;
  late final RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    _engine.destroy();
  }

  Future<void> _initEngine() async {
    RtcEngineContext context = RtcEngineContext(SpookerStrings.VideoCallAppId);
    _engine = await RtcEngine.createWithContext(context);
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _engine.joinChannel(
        SpookerStrings.VideoCallToken, widget.channelName, null, 0);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {},
      error: (errorCode) {},
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          _joined = true;
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          _users.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          _users.add(uid);
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [_renderLocalPreview(), _otherConfigurations(), _toolbar()],
        ),
      ),
    );
  }

  Widget _renderLocalPreview() {
    if (_joined && defaultTargetPlatform == TargetPlatform.android ||
        _joined && defaultTargetPlatform == TargetPlatform.iOS) {
      return RtcLocalView.SurfaceView(
        channelId: widget.channelName,
      );
    }
    if (_joined && defaultTargetPlatform == TargetPlatform.windows ||
        _joined && defaultTargetPlatform == TargetPlatform.macOS) {
      return RtcLocalView.TextureView(
        channelId: widget.channelName,
      );
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  Widget _otherConfigurations() {
    return Container(
      margin: EdgeInsets.all(SpookerSize.m20),
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: TagText('6 Live Now'),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: Text(
                'X',
                style: SpookerFonts.s24BoldLight,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
