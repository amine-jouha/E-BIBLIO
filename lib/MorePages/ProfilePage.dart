import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/exten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userInfo_model.dart';
import '../model/user_model.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}





class _ProfilePage1State extends State<ProfilePage1> {
  @override

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserInfos userInfos = UserInfos();

  void initState() {
    super.initState();
    setState(() {
    });

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  loggedInUser.userName == null ?
                  Text(
                  "${user!.displayName}".toCapitalized(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                  : Text(
                     "${loggedInUser.userName}",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'follow',
                        elevation: 0,
                        label: const Text("Follow"),
                        icon: const Icon(Icons.person_add_alt_1),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'mesage',
                        elevation: 0,
                        backgroundColor: Colors.red,
                        label: const Text("Logout"),
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatefulWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  @override
  State<_ProfileInfoRow> createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<_ProfileInfoRow> {

  UserInfos userInfos = UserInfos();
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    setState(() {
      userInfos.upgraded;
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
    final List<ProfileInfoItem> _items =  [
      ProfileInfoItem("Type Account", userInfos.upgraded == true ? 'seller' : 'normal'),
      ProfileInfoItem("Followers", '120'),
      ProfileInfoItem("Following", '200'),
    ];
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: _singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );
}

class ProfileInfoItem {
  String title;
  String value;
   ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatefulWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<_TopPortion> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration:  BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: user!.photoURL != null
                        // ? NetworkImage(user!.photoURL!)
                            ? CachedNetworkImageProvider(user!.photoURL!)
                        // ? CachedNetworkImageProvider('https://i.pinimg.com/originals/2f/11/d8/2f11d875e68791e2d29279cbff699a03.png')
                            : AssetImage('assets/avatar6.png') as ImageProvider,),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}