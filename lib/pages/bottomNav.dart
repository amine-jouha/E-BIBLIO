import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/AddBookToShop/bookShop.dart';
import 'package:ebiblio/MorePages/shop.dart';
import 'package:ebiblio/pages/SecondHome.dart';
import 'package:ebiblio/upgradeAccount/backToOld.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../audio_books/audioBook_page.dart';
import '../auth_users/Login.dart';
import '../controllers/google_signin_controller.dart';
import '../model/userInfo_model.dart';
import '../model/user_model.dart';
import '../upgradeAccount/upgradeAccount.dart';
import 'message_Page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
   late PageController _pageController;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserInfos userInfos = UserInfos();


  @override
  void initState() {
    super.initState();
    setState(() {
      userInfos.upgraded;
    });

    _pageController = PageController();
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

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    dynamic drawerHeader = UserAccountsDrawerHeader(
      accountName: loggedInUser.userName == null ?
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${user!.displayName}'.toUpperCase()),
          SizedBox(width: 5,),
          userInfos.upgraded==true ? Text('Seller', style: TextStyle(fontSize: 9,),) : Text('')
        ],
      ) :
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${loggedInUser.userName}'.toUpperCase()),
          SizedBox(width: 5,),
          userInfos.upgraded==true ? Text('Seller', style: TextStyle(fontSize: 9,),) : Text('')
        ],
      ),


      // arrowColor: Colors.indigo,
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      accountEmail: loggedInUser.email == null
        ? Text('${user!.email ?? ''}')
        : Text('${loggedInUser.email}'),
      // oublie pas de regler le probleme du ProfilePicture twitter
      currentAccountPicture: CircleAvatar(
        backgroundImage:
        user!.photoURL != null
            // ? NetworkImage(user!.photoURL!)
            ? CachedNetworkImageProvider(user!.photoURL!)
            // ? CachedNetworkImageProvider('https://i.pinimg.com/originals/2f/11/d8/2f11d875e68791e2d29279cbff699a03.png')
            : AssetImage('assets/avatar6.png') as ImageProvider,

      ),
      otherAccountsPictures: [
        IconButton(icon:Icon(Icons.logout), color: Colors.white, onPressed: () {
          logout(context);
          Provider.of<LoginController>(context, listen: false).logout();
        },),
      ],
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        // Divider(thickness: 1,),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: const Text('Market Place', style: TextStyle(fontSize: 18,),),
          ),

          leading: Icon(LineAwesomeIcons.store),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopEbiblio()));

          },
        ),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child:  Text(
              userInfos.upgraded == true
              ?'Back To Old Account'
              : 'Upgrade Account',
              style: TextStyle(fontSize: 18,),),
          ),
          leading: Icon(LineAwesomeIcons.business_time),
          onTap: (){
            if (userInfos.upgraded == false) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradeAccount()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BackToOLd()));
            }
          },
        ),
        Visibility(
          visible: userInfos.upgraded == true
          ? true
          : false ,
          child: ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            title: Transform.translate(
              offset: Offset(-16, 0),
              child: const Text('Add Book To Shop', style: TextStyle(fontSize: 18,),),
            ),
            leading: Icon(LineAwesomeIcons.shopping_bag),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookShop()));
            },
          ),
        ),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: const Text('Audio Books', style: TextStyle(fontSize: 18,),),
          ),
          leading: Icon(LineAwesomeIcons.audio_file_1),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookPage()));
          },
        ),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: const Text('Message Page', style: TextStyle(fontSize: 18,),),
          ),
          leading: Icon(LineAwesomeIcons.facebook_messenger),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagePage()));
          },
        ),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: const Text('Invitez un Ami', style: TextStyle(fontSize: 18,),),
          ),
          leading: Icon(LineAwesomeIcons.telegram),
          onTap: () async{
            final url = "https://jouham.com";
            await Share.share('Check out my website for more Infos \n $url');
          },
        ),
        ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: const Text('Contact E-biblio', style: TextStyle(fontSize: 18,),),
          ),
          leading: Icon(LineAwesomeIcons.envelope),
          onTap: (){},
        ),

        Divider(thickness: 1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.qrcode, color: Colors.white,)),
            IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.invision, color: Colors.white,))
          ],
        ),



      ],
    );

    // int _currentIndex = 0;
    // int _counter = 1;
    //
    // void _incrementCounter() {
    //   setState(() {
    //     _counter++;
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,

        // title:
        // Icon(LineAwesomeIcons.bars, color: Colors.black),
        // IconButton(icon: Icon(LineAwesomeIcons.bars, color:Colors.black ,), onPressed: () {  },),
        actions: [
          IconButton(icon: Icon(LineAwesomeIcons.user,color: Colors.black,), onPressed: () {},),
        ],),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 50,
      drawer: Drawer(
        child:
        drawerItems,
        backgroundColor: Colors.black87,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            SecondHome(),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        // containerHeight: 60,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.blue.shade400,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.bookmark),
            title: const Text('Book-Mark'),
            activeColor: Colors.pink.shade400,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: const Text(
              'Messages',
            ),
            activeColor: Colors.amber.shade400,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Colors.green.shade400,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
