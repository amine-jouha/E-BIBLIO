import 'dart:async';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/MorePages/bookInfos.dart';
import 'package:ebiblio/exten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ebiblio/model/userInfo_model.dart';
import 'package:ebiblio/pages/data_SecondHome.dart';
import 'package:ebiblio/pages/data_recomm.dart';
import 'package:ebiblio/pages/dialog.dart';
import 'package:ebiblio/pages/more_recommended.dart';
import 'package:ebiblio/upgradeAccount/upgradeAccount.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../auth_users/Login.dart';
import '../controllers/google_signin_controller.dart';
import '../dynamic_Link/dynamicLink.dart';
import '../dynamic_Link/page_test.dart';
import '../model/user_model.dart';
import '../providers/home_provider.dart';
import '../style_key.dart';
import 'message_Page.dart';

class SecondHome extends StatefulWidget {
  const SecondHome({Key? key}) : super(key: key);

  @override
  _SecondHomeState createState() => _SecondHomeState();
}

class _SecondHomeState extends State<SecondHome> {
  bool selected = false;
  bool justone = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserInfos userInfos = UserInfos();
  int _current = 0;
  double sizeW = 180;
  String url='';

  ///Retreive dynamic link firebase.
  void initDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    ////
    String link = 'https://revivefrr.page.link/6RQi';
    final PendingDynamicLinkData? _initialLink = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(link));

    if (deepLink != null) {
      handleDynamicLink(deepLink);
    }
    FirebaseDynamicLinks.instance.onLink;
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      // Handle errors
    });
  }

  handleDynamicLink(Uri url) {
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if (separatedString[1] == "post") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageTest(separatedString[2])));
    }
  }


  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];


  GlobalKey key = GlobalKey(debugLabel: 'd');
  GlobalKey _key1 = GlobalKey(debugLabel: 's');
  GlobalKey _key2 = GlobalKey(debugLabel: 'a');
  GlobalKey _key3 = GlobalKey(debugLabel: 'k');


  void _layout(_){
    Future.delayed(Duration(milliseconds: 100));
    showTutorial();
  }

  @override
  void initState() {
    super.initState();
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);

    //modify this

    Future.delayed(Duration(microseconds: 2), () {
      if (HProvider.isTuto == true && userInfos.ville == null) {
          HProvider.isTuto == false;
          initTargets();
          WidgetsBinding.instance.addPostFrameCallback(_layout);
      }
    });

    initDynamicLinks();
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    FirebaseFirestore.instance.collection('UserInfo').doc(user!.uid).get().then((value) {
      this.userInfos = UserInfos.fromMap(value.data());
      setState(() {});
    });
    // final userCollection = FirebaseFirestore.instance.collection('UserInfo').where('ville', whereIn: );
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .where('uid', isNull:null)
    //     .get()
    //     .then((value) => {
    //   openDialog()
    // });
  }

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 400),
      height: 4,
      width: _current == index ? 22 : 9,
      decoration: BoxDecoration(
        color: _current == index ? Colors.orange : Colors.grey.shade300,
        // shape: _current == index ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: _current == index ? BorderRadius.circular(30) : BorderRadius.circular(5),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async {
    return showDialog<bool>(
      context : context,
      builder : (context) => AlertDialog(
        title: Text("Warning!"),
        content: Text("Do you want to logout?!"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Yes")),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Nop",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void openDialog()  async{
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              // title: Text('Steps to do'),
              content: SingleChildScrollView(
                child: Column(
                  // alignment: Alignment.topCenter,
                  // overflow: Overflow.visible,
                  children: [
                    Container(
                        height: 80,
                        // color:Colors.blue,
                        child: Image.asset('assets/ebiblio2.png',fit: BoxFit.contain, height: 80,)
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 350,
                      child: MyDialog(),

                    ),
                  ],
                ),
              ))

      );

    }
    Future.delayed(Duration(seconds: 4), () {
      if (userInfos.ville == null) {
        if (justone == false) {
          justone = true;
          openDialog();
          print(userInfos.uid);
          print(userInfos.ville);
          ;}
      }});
    //  FirebaseFirestore.instance
    //     .collection('UserInfo')
    //     .where('ville')
    //     .get()
    //     .then((value) => {
    //       openDialog()
    // });

    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text('Hi ${
                        loggedInUser.userName == null ?
                        user!.displayName :
                        loggedInUser.userName
                    } :)', style: TextStyle(fontSize: 18, ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recommended for You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, right: 8.0),
                          child: GestureDetector(
                              key: _key1,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SeeRecommended()));
                              },
                              child: Text('See More>', style: TextStyle(fontSize: 12,decoration: TextDecoration.underline, color: Colors.orange ),)
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    child: Stack(
                      children: [
                        Padding(
                          key: key,
                          padding: const EdgeInsets.all(8.0),
                          child: CarouselSlider.builder(

                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16/9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                viewportFraction: 1,
                                height: 220,
                                onPageChanged: (value, carousel) {
                                  setState(() {
                                    _current = value;
                                  });
                                }
                            ),
                            itemCount: imgBook.length,
                            itemBuilder: (BuildContext context, index, realIdx ) {
                              if (userInfos.type == null) {
                                return Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:BorderRadius.circular(10),
                                        child: Stack(
                                            children: [
                                              Opacity(
                                                  opacity:0.7,
                                                  child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover)
                                              ),
                                              BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: ClipRRect(
                                                      borderRadius:BorderRadius.circular(10),
                                                      // child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                      Positioned(
                                        left: 100,
                                        top: 50,
                                        child: Container(
                                          // height:110% MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width/1.4,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                ],
                                              ),
                                              trailing:Container(
                                                  height: double.infinity,
                                                  child: Icon(LineAwesomeIcons.angle_right, color:Colors.orange,)
                                              ),

                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );

                              }if (userInfos.type!.contains(onFictif[index].type)) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                                      image: onFictif[index].imageBook,
                                      title: onFictif[index].title,
                                      author: onFictif[index].name,
                                      tag: 'tagImage$index',
                                    )));
                                  },
                                  child: Container(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height:220,
                                          width: 160,
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(10),
                                            child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  Opacity(opacity:0.5,child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover)),
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: ClipRRect(
                                                          borderRadius:BorderRadius.circular(10),
                                                          child: Hero(
                                                              tag: 'tagImage$index',
                                                              child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 100,
                                          top: 40,
                                          child: Container(
                                            // height:110% MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width/1.4,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: ListTile(
                                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                      child: Text(onFictif[index].title.toTitleCase(), style: TextStyle(color: Colors.black12, fontSize: 15,),),
                                                    ),
                                                    Text(onFictif[index].title.toTitleCase(), style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17,
                                                        letterSpacing: 0.3,
                                                        color: Colors.blueGrey.shade800
                                                    ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ],
                                                ),
                                                trailing:Container(
                                                    height: double.infinity,
                                                    child: Icon(LineAwesomeIcons.angle_right, color:Colors.orange,)
                                                ),

                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                                      image: onFictif[index].imageBook,
                                      title: onFictif[index].title,
                                      author: onFictif[index].name,
                                      tag: 'tagImage$index',
                                    )));
                                  },
                                  child: Container(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height:220,
                                          width: 160,
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(10),
                                            child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                Opacity(opacity:0.5,child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover)),
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: ClipRRect(
                                                          borderRadius:BorderRadius.circular(10),
                                                          child: Hero(
                                                              tag: 'tagImage$index',
                                                              child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 100,
                                          top: 40,
                                          child: Container(
                                            // height:110% MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width/1.4,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: ListTile(
                                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                      child: Text('data of books', style: TextStyle(color: Colors.black12, fontSize: 15,),),
                                                    ),
                                                    Text(onFictif[index].title, style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        letterSpacing: 0.3,
                                                        color: Colors.blueGrey.shade800
                                                    ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis
                                                    ),
                                                  ],
                                                ),
                                                trailing:Container(
                                                    height: double.infinity,
                                                    child: Icon(LineAwesomeIcons.angle_right, color:Colors.orange,)
                                                ),

                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }

                            },


                          ),
                        ),
                        Positioned(
                          top: 220,
                          right: 5% MediaQuery.of(context).size.width,


                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                imgBook.length,
                                    (index) => dotIndicator(index)
                            ),),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 30,),
                  Padding(
                    key: _key2,
                    padding: const EdgeInsets.only(left: 18),
                    child: Text('In Your City', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                        itemCount: onFictif.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                                image: onFictif[index].imageBook,
                                title: onFictif[index].title,
                                tag: 'taggImage$index',
                                author: onFictif[index].name,
                              )));
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 5,),
                                      Container(
                                        // height: 200,
                                        // width: MediaQuery.of(context).size.width/2.9,
                                        width: 135,
                                        // color:Colors.pink,
                                        child: Column(
                                          children: [

                                            ClipRRect(
                                              borderRadius:BorderRadius.circular(10),
                                              child: Container(
                                                height: sizeW,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Opacity(opacity:0.5,child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)),
                                                    BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: ClipRRect(
                                                            borderRadius:BorderRadius.circular(7),
                                                            child: Hero(
                                                                tag: 'taggImage$index',
                                                                child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // ClipRRect(
                                            //   borderRadius:BorderRadius.circular(10),
                                            //   child: Container(
                                            //       height: 260,
                                            //       width: MediaQuery.of(context).size.width/2,
                                            //       child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,
                                            //       )),
                                            // ),
                                            // SizedBox(height: 5,),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text('Yes Went Like Going To My Home When Like How Mike So My Brother'.toTitleCase(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Inter",
                                                        color: Colors.black.withOpacity(0.8),
                                                        fontSize: 12.5
                                                    ),
                                                    maxLines: 2,
                                                    overflow:TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 10,),
                                                  // Container(
                                                  //   width: sizeW,
                                                  //   child: Row(
                                                  //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  //
                                                  //     children: [
                                                  //       CircleAvatar(
                                                  //         radius: 10,
                                                  //         backgroundImage: AssetImage(onFictif[index].imageProfil),
                                                  //       ),
                                                  //       SizedBox(width: 5,),
                                                  //       Container(
                                                  //         // color: Colors.blue,
                                                  //           width: sizeW/2,
                                                  //           child: Text(onFictif[index].name, style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,)
                                                  //       )
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  Container(
                                                    width: sizeW,
                                                    child: Text('\$25.00', style: TextStyle(fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      // SizedBox(width: 15,),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5,)
                              ],
                            ),
                          );
                        }
                    ),),
                  // SizedBox(
                  //   height: 213,
                  //   child: ListView.builder(
                  //       itemCount: name.length,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return CardsCont(imgBook: imgBook[index],
                  //           name: name[index],
                  //           title: title[index],
                  //           description: description[index],
                  //           avatar: avatar[index],
                  //         );
                  //       }
                  //   ),),
                  SizedBox(height: 20,),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Live Section',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  Container(
                    key: _key3,
                    height: 100,
                    child: ListView.builder(
                        itemCount: avatar.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              SizedBox(width: 6),
                              CircleAvatar(
                                radius:50,
                                backgroundColor: Colors.redAccent,
                                child: CircleAvatar(
                                  // backgroundColor: Colors.redAccent,
                                  backgroundImage: AssetImage(avatar[index]),
                                  radius: 48,
                                ),
                              ),
                              SizedBox(width: 10,),
                            ],
                          );
                        }
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: Colors.grey,
                    height: 60,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      url = await AppUtils.buildDynamicLink();
                    } catch (e) {
                      print(e);
                    }
                    setState(() {});
                    await Share.share('Check out my website for more Infos \n $url');
                  },
                  child: Text(
                    "Generate Dynamic Link",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void initTargets() {
    targets.add(TargetFocus(
        identify: "Target 0",
        keyTarget: _key1,
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
    targets.add(TargetFocus(
        identify: "Target 1",
        keyTarget: key,
        color: Colors.red,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Example of Book",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "The Book Here is a Example for a book you can like because it's in your favorite book's type",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: _key2,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Book In Your City",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Yes, You can change your book with another just in your City",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )),
        TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "BUT We Have Some Rules",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  child: Text(
                    "E-Biblio protect their users and her policy so, when you have to change your book do it in e-biblio",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: _key3,
      color: Colors.grey,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/ebiblio2.png",fit: BoxFit.contain,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "E-biblio Live",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "You Can live and chat in e-biblio and speak with others about whatever in books",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
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

class CardsCont extends StatefulWidget {
  final String title;
  final String description;
  final String name;
  final String imgBook;
  final String avatar;
  const CardsCont({Key? key,
    required this.title,
    required this.description,
    required this.name,
    required this.imgBook,
    required this.avatar,
  }) : super(key: key);


  @override
  State<CardsCont> createState() => _CardsContState();
}

class _CardsContState extends State<CardsCont> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child:
      Row(
        children: [
          SizedBox(width: 5,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/raw4.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(0.5),
                          BlendMode.dstATop),
                    )
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                        width: selected ? 330.0 : 170.0,//**********
                        // width: selected1 ? 330
                        //     : selected2 ? 330
                        //     : selected3 ? 330
                        //     : selected4 ? 330
                        //     : 170,
                        height: 205.0,


                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 1,
                        //     blurRadius: 1,
                        //     offset: Offset(4, 8), // changes position of shadow
                        //   ),
                        // ],

                        // color: selected ? Colors.cyan : Colors.brown,
                        // alignment:selected ? Alignment.center : AlignmentDirectional.bottomCenter,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    // height: 110,
                                    // color: Colors.white,
                                    child: Column(
                                      children: [
                                        // Visibility(
                                        //   child: Text('la vie dartiste',),
                                        //   visible: selected,
                                        // ),
                                        Container(
                                          width: 95,
                                          child: Image(
                                            image: AssetImage(
                                                widget.imgBook),
                                            height: 115,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                    alignment:selected//**********
                                        ? AlignmentDirectional
                                        .topStart
                                        : AlignmentDirectional
                                        .center,
                                    //   selected1 ? AlignmentDirectional.topStart
                                    // : selected2 ? AlignmentDirectional.topStart
                                    // : selected3 ? AlignmentDirectional.topStart
                                    // : selected4 ? AlignmentDirectional.topStart
                                    //       : AlignmentDirectional.center, //**********


                                    duration: const Duration(
                                        milliseconds: 500),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 23),
                                    child: Visibility(
                                      visible: selected,
                                      // fre == 0 ? true : false,//**********
                                      child: AnimatedContainer(
                                        // color: Colors.blue,
                                        alignment: AlignmentDirectional
                                            .centerEnd,
                                        // selected//**********
                                        //     ? AlignmentDirectional
                                        //     .centerEnd
                                        //     : AlignmentDirectional
                                        //     .topStart,
                                        duration: Duration(milliseconds: 800),
                                        child: FittedBox(
                                          child: AnimatedOpacity(
                                            child: Text(widget.description),
                                            opacity:selected ? 1: 0,
                                            // width == 330 ? 1 : 0,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.slowMiddle,
                                          ),
                                        ),
                                      ),

                                      // const FlutterLogo(size: 50),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 134, left: 180),
                                    child: Visibility(
                                      visible: selected,//**********
                                      child: Image(image: AssetImage(
                                        'assets/star.png',),
                                        height: 65,),

                                      // const FlutterLogo(size: 50),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    height: 135,
                                    color: Colors.transparent,
                                    duration: Duration(milliseconds: 800),
                                    child: Text(widget.title,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        // fontFamily: 'Yellowtail',
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                    alignment: selected//**********
                                        ? AlignmentDirectional.topCenter
                                        : AlignmentDirectional
                                        .bottomCenter,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 145),
                                    child: AnimatedContainer(
                                      // color: Colors.red,
                                      duration: Duration(milliseconds: 800),
                                      alignment: selected//**********
                                          ? AlignmentDirectional
                                          .bottomStart
                                          : AlignmentDirectional
                                          .bottomStart,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(left: 3.0),
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  widget.avatar),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(widget.name,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight
                                                    .bold),),
                                          SizedBox(width: 10,),

                                          // Visibility(
                                          //   visible: selected ,
                                          //   child: Image(image: AssetImage('assets/star.png',),height: 50,)
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
        ],
      ),
    );
  }

}



//
// class Ondialogue extends StatefulWidget {
//
//   @override
//   _OndialogueState createState() => _OndialogueState();
// }
//
// class _OndialogueState extends State<Ondialogue> {
//   int _currentStep = 0;
//   final double spacing = 8;
//   bool check = false;
//   bool isComplete = false;
//   String? value;
//   StepperType stepperType = StepperType.vertical;
//   final  ville = ['Agadir','Rabat', 'Marrakech', 'Fes', 'Chefchaouen', 'Essaouira', 'Casablanca', 'Tanger' ];
//
//   switchStepsType() {
//     setState(() => stepperType == StepperType.vertical
//         ? stepperType = StepperType.horizontal
//         : stepperType = StepperType.vertical);
//   }
//
//   tapped(int step){
//     setState(() => _currentStep = step);
//   }
//
//   continued(){
//     _currentStep < 2 ? setState(() => _currentStep += 1): null;
//   }
//   cancel(){
//     _currentStep > 0 ?
//     setState(() => _currentStep -= 1) : null;
//   }
//
//
//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),)
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: openDialog(),
//     );
//   }
//   openDialog()  async{
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) => AlertDialog(
//             insetPadding: EdgeInsets.symmetric(horizontal: 20),
//             title: Text('Steps to do'),
//             content: Stack(
//               children: [
//                 Container(
//                   height: 150,
//                   color:Colors.blue,
//                     child: Image.asset('assets/ebiblio2.png',fit: BoxFit.contain, height: 120,)
//                 ),
//                 Container(
//                   width: double.maxFinite,
//                   height: 350,
//                   child: MyDialog(),
//
//                   ),
//               ],
//             ))
//     );
//   }
// }





