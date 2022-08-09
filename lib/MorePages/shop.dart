import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/MorePages/info_popular.dart';
import 'package:ebiblio/data_fictif/decFictif.dart';
import 'package:ebiblio/data_fictif/moFictif.dart';
import 'package:ebiblio/exten.dart';
import 'package:ebiblio/model/Book_model.dart';
import 'package:ebiblio/model/bookModel.dart';
import 'package:ebiblio/pages_slider/list.dart';
import 'package:ebiblio/providers/home_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../data_fictif/kiFictif.dart';
import '../model/userInfo_model.dart';
import '../model/user_model.dart';
import '../pages/data_recomm.dart';
import 'bookInfos.dart';

class ShopEbiblio extends StatefulWidget {
  const ShopEbiblio({Key? key}) : super(key: key);

  @override
  State<ShopEbiblio> createState() => _ShopEbiblioState();
}

Future<Widget> _getImageFB(BuildContext context, String imageName) async {
  late Image image;
  await FireStorageService.loadImage(context, imageName).then((value) => {
    image = Image.network(
      value.toString(),
      fit: BoxFit.cover,
      height: 142,
      width: 130,
    ),
  });
  return image;
}

class _ShopEbiblioState extends State<ShopEbiblio> {
  final controller = TextEditingController();
  List<Fictif> pdItems = onFictif;
  double sizeW = 180;
  double sizeX = 160;
  HomeProvider? _provider;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserInfos userInfos = UserInfos();
  BookFormShop bookFormInfo = BookFormShop();

  @override
  void initState() {
    super.initState();
    // _provider!.books;
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    FirebaseFirestore.instance.collection('UserInfo').doc(user!.uid).get().then((value) {
      this.userInfos = UserInfos.fromMap(value.data());
      setState(() {});
    });
    FirebaseFirestore.instance.collection('BookFormShop').doc(user!.uid).get().then((value) {
      this.bookFormInfo = BookFormShop.fromMap(value.data());
      setState(() {});
    });
    // _provider = Provider.of<HomeProvider>(context, listen: false);
    // _provider!.query;
    // _provider?.getBooks();


  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("E-biblio Shop", style: TextStyle(color: Colors.grey.shade800),),
          elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left, color: Colors.black,),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    child: CupertinoSearchTextField(
                      placeholder: "Search your book...".toTitleCase(),
                      controller: controller,
                      onChanged: searchPodcast,
                    ),
                    width: MediaQuery.of(context).size.width ,
                    height: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Your Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
             //recent books you have read
             child: userInfos.bookInShop != null && userInfos.bookInShop != 0
                ? SizedBox(
                   height: 300,
                   child: ListView.builder(
                       itemCount: userInfos.bookInShop,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                               image: onFictif[index].imageBook,
                               title: onFictif[index].title,
                               author: onFictif[index].name,
                               tag: 'r$index',
                             )));
                           },
                           child: Row(
                             children: [
                               SizedBox(width: 5,),
                               Row(
                                 children: [
                                   // SizedBox(width: 5,),
                                   Container(
                                     // height: 200,
                                     // width: MediaQuery.of(context).size.width/2.9,
                                     width: 120,
                                     // color:Colors.pink,
                                     child: Column(
                                       children: [
                                         ClipRRect(
                                           borderRadius:BorderRadius.circular(10),
                                           child: Container(
                                             height: sizeX,
                                             child: Stack(
                                               fit: StackFit.expand,
                                               children: [
                                                 Opacity(opacity:0.5, child:
                                                  FutureBuilder<Widget>(
                                                   future: _getImageFB(context, 'book${loggedInUser.uid.toString()}/book${index}/0${loggedInUser.userName.toString()}'),
                                                   builder: (context, snapshot) {
                                                     if (snapshot.hasData)
                                                       if (snapshot.connectionState == ConnectionState.done) {
                                                         print('le voici');
                                                         print(snapshot.data);
                                                         return
                                                           Container(
                                                             height: 60,
                                                             child: snapshot.data ?? Image.asset('assets/cover2.jpg', fit: BoxFit.cover,),
                                                           );

                                                       }
                                                     if (snapshot.connectionState == ConnectionState.waiting) {
                                                       return Image.asset('assets/cover2.jpg', fit: BoxFit.cover,);
                                                     }
                                                     else return Image.asset('assets/cover2.jpg', fit: BoxFit.cover,);
                                                   },
                                                 ),
                                                 ),
                                                 BackdropFilter(
                                                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(10.0),
                                                     child: ClipRRect(
                                                         borderRadius:BorderRadius.circular(7),
                                                         child: Hero(
                                                             tag: 'r$index',
                                                             child: FutureBuilder<Widget>(
                                                               future: _getImageFB(context, 'book${loggedInUser.uid.toString()}/book${index}/0${loggedInUser.userName.toString()}'),
                                                               builder: (context, snapshot) {
                                                                 if (snapshot.hasData)
                                                                   if (snapshot.connectionState == ConnectionState.done) {
                                                                     print('le voici');
                                                                     print(snapshot.data);
                                                                     return
                                                                       Container(
                                                                         height: 60,
                                                                         child: snapshot.data,
                                                                       );

                                                                   }
                                                                 if (snapshot.connectionState == ConnectionState.waiting) {
                                                                   return Image.asset('assets/cover2.jpg', fit: BoxFit.cover,);
                                                                 }
                                                                 else return Image.asset('assets/cover2.jpg', fit: BoxFit.cover,);
                                                               },
                                                             ),
                                                             // Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
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
                                         SizedBox(height: 10,),
                                         Padding(
                                           padding: const EdgeInsets.all(10.0),
                                           child: Column(
                                             children: [
                                               // Text(
                                               //   'Yes${bookFormInfo.title}  Went LikeGoing To My Home When Like How Mike So My Brother'.toTitleCase(),
                                               //
                                               //   style: TextStyle(
                                               //       fontWeight: FontWeight.bold,
                                               //       fontFamily: "Inter",
                                               //       color: Colors.black.withOpacity(0.8),
                                               //       fontSize: 12.5
                                               //   ),
                                               //   maxLines: 2,
                                               //   overflow:TextOverflow.ellipsis,
                                               // ),
                                               StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                 stream: FirebaseFirestore.instance.collection('BookFormShop').snapshots(),
                                                 builder: (_, snapshot) {
                                                   if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                                                   if (snapshot.hasData) {
                                                     final docs = snapshot.data!.docs;
                                                     final data = docs[index].data();
                                                     return Text(data['title']);
                                                     // return ListView.builder(
                                                     //   itemCount: docs.length,
                                                     //   itemBuilder: (_, i) {
                                                     //     final data = docs[i].data();
                                                     //     return ListTile(
                                                     //       title: Text(data['title']),
                                                     //       subtitle: Text(data['price']),
                                                     //     );
                                                     //   },
                                                     // );
                                                   }

                                                   return Center(child: CircularProgressIndicator());
                                                 },
                                               ),
                                               SizedBox(height: 5,),
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
                                               StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                 stream: FirebaseFirestore.instance.collection('BookFormShop').snapshots(),
                                                 builder: (_, snapshot) {
                                                   if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                                                   if (snapshot.hasData) {
                                                     final docs = snapshot.data!.docs;
                                                     final data = docs[index].data();
                                                     return Container(
                                                       width: sizeW,
                                                       child: Text("${data['price']}\$", style: TextStyle(fontWeight: FontWeight.bold),),
                                                     );
                                                     // return ListView.builder(
                                                     //   itemCount: docs.length,
                                                     //   itemBuilder: (_, i) {
                                                     //     final data = docs[i].data();
                                                     //     return ListTile(
                                                     //       title: Text(data['title']),
                                                     //       subtitle: Text(data['price']),
                                                     //     );
                                                     //   },
                                                     // );
                                                   }

                                                   return Center(child: CircularProgressIndicator());
                                                 },
                                               ),

                                             ],
                                           ),
                                         ),

                                       ],
                                     ),
                                   ),
                                   // SizedBox(width: 15,),
                                 ],
                               ),
                               SizedBox(width: 5,)
                             ],
                           ),
                         );
                       }
                   ),)
                : SvgPicture.asset('assets/svg/nothing.svg',),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Populars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Consumer<HomeProvider>(
                      builder: (context, provideeer, widget)=>GestureDetector(
                          onTap: () {
                            setState(() {
                              _provider!.books = [];
                              print(provideeer.query);
                              provideeer.query = 'nature and mountain';
                              print(provideeer.query);
                            });

                            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPopular()));
                          },
                          child: Icon(Icons.keyboard_arrow_right)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: onFictif.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                          image: onFictif[index].imageBook,
                          title: onFictif[index].title,
                          author: onFictif[index].name,
                          tag: 'r$index',
                        )));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Row(
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
                                                        tag: 'r$index',
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
                                    SizedBox(height: 10,),
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
                          SizedBox(width: 5,)
                        ],
                      ),
                    );
                  }
              ),),
            SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Best Sellers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: onFictif.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0,),
                    child: Card(
                      child: Container(
                        // height: 260,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/raw5.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.white.withOpacity(0.3), BlendMode.dstATop),
                            )
                        ),
                        width: MediaQuery.of(context).size.width - 35,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(onFictif[index].imageProfil),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(onFictif[index].name),
                                      ),
                                      Container(
                                        child: Text('Agadir', style: TextStyle(fontSize: 9, color: Colors.grey.shade500) ,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              width:MediaQuery.of(context).size.width - 50,
                              child: Text('im a seller of book, sometime i have my book and sometime i sell book of others'
                                  'so if you check my account'
                                  .toTitleCase(), textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis, maxLines: 2,style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade700
                              ),),
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                  itemCount: onFictif.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                                          image: onFictif[index].imageBook,
                                          title: onFictif[index].title,
                                          tag: 't$index',
                                          author: onFictif[index].name,
                                        )));
                                      },
                                      child: Row(
                                        children: [
                                          // SizedBox(width: 5,),
                                          Row(
                                            children: [
                                              // SizedBox(width: 5,),
                                              Container(
                                                // height: 200,
                                                // width: MediaQuery.of(context).size.width/2.9,
                                                width: 80,
                                                // color:Colors.pink,
                                                child: Column(
                                                  children: [

                                                    ClipRRect(
                                                      borderRadius:BorderRadius.circular(10),
                                                      child: Container(
                                                        height: 110,
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: [
                                                            // Opacity(opacity:0.5,child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)),
                                                            Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: ClipRRect(
                                                                  borderRadius:BorderRadius.circular(7),
                                                                  child: Hero(
                                                                      tag: 't$index',
                                                                      child: Image.asset(onFictif[index].imageBook, fit: BoxFit.cover,)
                                                                  )
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                      child: Column(
                                                        children: [
                                                          Text('Yes Went Like Going To My Home When Like How Mike So My Brother'.toTitleCase(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "Inter",
                                                                color: Colors.black.withOpacity(0.8),
                                                                fontSize: 9
                                                            ),
                                                            maxLines: 2,
                                                            overflow:TextOverflow.ellipsis,
                                                          ),
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
                                                          // Container(
                                                          //   width: sizeW,
                                                          //   child: Text('\$25.00', style: TextStyle(fontWeight: FontWeight.bold),),
                                                          // )
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              // SizedBox(width: 15,),
                                            ],
                                          ),
                                          // SizedBox(width: 5,)
                                        ],
                                      ),
                                    );
                                  }
                              ),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Classic Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Consumer<HomeProvider>(
                      builder: (context, provideeer, widget)=>GestureDetector(
                        onTap: () {
                          setState(() {
                            _provider!.books = [];
                            print(provideeer.query);
                            provideeer.query = 'classic books';
                            print(provideeer.query);

                          });

                          Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPopular()));
                        },
                          child: Icon(Icons.keyboard_arrow_right)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: onKifictif.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                          image: onKifictif[index].imageBook,
                          title: onKifictif[index].title,
                          tag: 'tagg0Image$index',
                          author: onKifictif[index].name,
                        )));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Row(
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
                                            Opacity(opacity:0.5,child: Image.asset(onKifictif[index].imageBook, fit: BoxFit.cover,)),
                                            BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ClipRRect(
                                                    borderRadius:BorderRadius.circular(7),
                                                    child: Hero(
                                                        tag: 'tagg0Image$index',
                                                        child: Image.asset(onKifictif[index].imageBook, fit: BoxFit.cover,)
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text('book of the last thing in the past when we say no'.toTitleCase(),
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
                          SizedBox(width: 5,)
                        ],
                      ),
                    );
                  }
              ),),
            SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Love Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Consumer<HomeProvider>(
                      builder: (context, provideeer, widget)=>InkWell(
                          onTap: () {
                            _provider!.books = [];
                            provideeer.query = 'Love book';
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPopular()));
                          },
                          child: Icon(Icons.keyboard_arrow_right)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 270,
              child: ListView.builder(
                  itemCount: onMoFictif.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                          image: onMoFictif[index].imageBook,
                          title: onMoFictif[index].title,
                          tag: 'j$index',
                          author: onMoFictif[index].name,
                        )));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Row(
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
                                            Opacity(opacity:0.5,child: Image.asset(onMoFictif[index].imageBook, fit: BoxFit.cover,)),
                                            BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ClipRRect(
                                                    borderRadius:BorderRadius.circular(7),
                                                    child: Hero(
                                                        tag: 'j$index',
                                                        child: Image.asset(onMoFictif[index].imageBook, fit: BoxFit.cover,)
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text('book of the last thing in the past when we say no'.toTitleCase(),
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
                          SizedBox(width: 5,)
                        ],
                      ),
                    );
                  }
              ),),
            SizedBox(height: 15,),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 60,
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width:120,
                            // color: Colors.red,
                            child: Text('stories that can interest you'.toTitleCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'Inter'
                              ),
                              // textAlign: TextAlign.justify,
                            )
                          ),
                        ),
                        SizedBox(height: 5,),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(left: 30, right: 30)),
                            elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)
                                  )
                              ),
                            backgroundColor: MaterialStateProperty.all(Colors.transparent)
                          ),
                            onPressed: () {},
                            child: Text('Discover', style: TextStyle(color: Colors.black),)
                        )
                      ],
                    ),
                    Container(
                      // height: 150,
                      width: 160,
                      // color: Colors.blue,
                      child: SvgPicture.asset('assets/svg/woman.svg',fit: BoxFit.cover,),
                    )
                  ],
                ),
              )
            ),
            SizedBox(height: 25,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Detective Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Consumer<HomeProvider>(
                      builder: (context, provideeer, widget)=>InkWell(
                          onTap: () {
                            _provider!.books = [];
                            provideeer.query = 'Detective book';
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPopular()));
                          },
                          child: Icon(Icons.keyboard_arrow_right)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: onDecFictif.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                          image: onDecFictif[index].imageBook,
                          title: onDecFictif[index].title,
                          tag: 'x$index',
                          author: onDecFictif[index].name,
                        )));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Row(
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
                                            Opacity(opacity:0.5,child: Image.asset(onDecFictif[index].imageBook, fit: BoxFit.cover,)),
                                            BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ClipRRect(
                                                    borderRadius:BorderRadius.circular(7),
                                                    child: Hero(
                                                        tag: 'x$index',
                                                        child: Image.asset(onDecFictif[index].imageBook, fit: BoxFit.cover,)
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text('book of the last thing in the past when we say no'.toTitleCase(),
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
                          SizedBox(width: 5,)
                        ],
                      ),
                    );
                  }
              ),),
          ],
        ),
      ),
    );
  }
  void searchPodcast(String query) {
    final suggestion = onFictif.where((pd)  {
      final PdTitle = pd.title.toString().toLowerCase();
      final Pdjournaliste = pd.name.toString().toLowerCase();
      final input = query.toLowerCase();

      return PdTitle.contains(input) || Pdjournaliste.contains(input);
    }).toList();

    setState(() {
      pdItems = suggestion;
    });

  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

}
