import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../model/userInfo_model.dart';
import '../providers/home_provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  UserInfos userInfos = UserInfos();
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];


  void _layout(_){
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

  GlobalKey keyM = GlobalKey(debugLabel: 'ws');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(Duration(microseconds: 2), () {
      if (HProvider.isTuto == true && userInfos.ville == null) {
        HProvider.isTuto == false;
        initTargets();
        WidgetsBinding.instance.addPostFrameCallback(_layout);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Page'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(
              child: Container(
                key:keyM,
                color: Colors.blueAccent,
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                color: Colors.blueAccent,
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void initTargets() {
    targets.add(TargetFocus(
      identify: "Message Target",
      keyTarget: keyM,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "See More",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "See More Books in Recommended for you, according to your type's Book Choice",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ))
      ],
    ));
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);
    HProvider.changeTutoBool();


  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.brown,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MessagePage()), (route) => false);

      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MessagePage()), (route) => false);

      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

}
