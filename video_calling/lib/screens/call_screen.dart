import 'package:flutter/material.dart';
import 'package:video_calling/constants.dart';
import 'package:video_calling/screens/login_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MyCall extends StatelessWidget {
  final String callID;
  const MyCall({super.key, required this.callID});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: MyConst
          .AppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: MyConst
          .AppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: MyLogin.userId,
      userName: MyLogin.name,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
