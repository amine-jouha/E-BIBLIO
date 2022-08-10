import 'dart:ui';

import 'package:ebiblio/exten.dart';
import 'package:ebiblio/pages/SecondHome.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../pages/bottomNav.dart';

class BookInfos extends StatefulWidget {
  const BookInfos({Key? key, this.image, this.title, this.author, this.tag}) : super(key: key);
  final image;
  final title;
  final author;
  final tag;

  @override
  State<BookInfos> createState() => _BookInfosState();
}

class _BookInfosState extends State<BookInfos> {
   String? firstHalf;
   String? secondHalf;
  final String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum neque'
      ' egestas congue quisque egestas diam. Vulputate ut pharetra sit amet. Tortor'
      ' id aliquet lectus proin nibh nisl. Pretium quam vulputate dignissim suspendisse.'
      ' id aliquet lectus proin nibh nisl. Pretium quam vulputate dignissim suspendisse.'
      ' id aliquet lectus proin nibh nisl. Pretium quam vulputate dignissim suspendisse.'
      ' id aliquet lectus proin nibh nisl. Pretium quam vulputate dignissim suspendisse.'
      ' id aliquet lectus proin nibh nisl. Pretium quam vulputate dignissim suspendisse.'
      ' Dignissim cras tincidunt lobortis feugiat vivamus at augue. Justo nec ultrices dui'
      ' Dignissim cras tincidunt lobortis feugiat vivamus at augue. Justo nec ultrices dui'
      ' Dignissim cras tincidunt lobortis feugiat vivamus at augue. Justo nec ultrices dui'
      ' sapien eget mi proin sed. Viverra maecenas accumsan lacus vel facilisis volutpat est'
      ' velit. Cursus turpis massa tincidunt dui ut ornare. Libero id faucibus nisl tincidunt'
      ' eget. Nullam ac tortor vitae purus.';

  bool flag = true;
  @override
  void initState() {
    super.initState();

    if (description.length > 550) {
      firstHalf = description.substring(0, 550);
      secondHalf = description.substring(550, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Container(
            //   color: Colors.grey.withOpacity(0.2),
            //   height: 60,
            //   child: Icon(Icons.bookmark),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
                  minimumSize: MaterialStateProperty.all(Size.square(50))
                ),
                  onPressed: () {},
                  child: Icon(Icons.bookmark)
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                      minimumSize: MaterialStateProperty.all(Size.square(50))

                    ),
                    onPressed: () {},
                    child: Text('Contact Seller', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Inter',letterSpacing: 0.4, color: Colors.white
                    ))
                ),
              ),
            ),
            // Container(
            //   height: 60,
            //
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.amber,
            //   ),
            //   child: Center(child: Text('Contact Seller', style: TextStyle(
            //     fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white
            //   ),)),
            // ),

          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('${widget.title}'.toTitleCase()) ,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left, color: Colors.black,),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Stack(children: [
                        Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Opacity(opacity:0.4,child: Image.asset(widget.image, fit: BoxFit.cover,))
                        ),
                        Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              gradient: LinearGradient(
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.9),
                                    Colors.white.withOpacity(0),
                                    Colors.white.withOpacity(0.9),
                                  ],
                                  // stops: [
                                  //   0.0,
                                  //   1.0
                                  // ]
                              )),
                        )
                      ]),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Visibility(
                            visible: false,
                            child: Image.asset(widget.image, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 280,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 200,
                            width: 140,
                            child: Hero(
                                tag: widget.tag,
                                child: Image.asset(widget.image, fit: BoxFit.cover,)
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('author: ${widget.author}'.toTitleCase(), style: TextStyle(color: Colors.grey.shade600,fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),),
                            SizedBox(height: 5,),
                            Text('november 14, 2022'.toTitleCase(), style: TextStyle(color: Colors.grey.shade400,fontSize: 12),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade500.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/pstar.png",height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Text('/5', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10, color: Colors.grey),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      Container(height:25,child: VerticalDivider(thickness: 1,)),
                      Container(
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('4,2k', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                SizedBox(width: 2,),
                                Text('read'.toTitleCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10, color: Colors.grey),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      Container(height:25,child: VerticalDivider(thickness: 1,)),
                      Container(
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('340', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                SizedBox(width: 2,),
                                Text('pages'.toTitleCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10, color: Colors.grey),)
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Text(
                        'Synopsis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start
                        ,)
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: secondHalf!.isEmpty
                        ?  Text(firstHalf!, textAlign: TextAlign.justify,style:TextStyle(color: Colors.grey.shade700))
                        :  Column(
                              children: <Widget>[
                                  Stack(
                                      children: [
                                        Container(
                                            child: Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!) ,style:TextStyle(color: Colors.grey.shade700), textAlign: TextAlign.justify,)
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                              gradient: LinearGradient(
                                                begin: FractionalOffset.bottomCenter,
                                                end: FractionalOffset.topCenter,
                                                colors: [
                                                  Colors.white.withOpacity(0.8),
                                                  Colors.white.withOpacity(0),
                                                  Colors.white.withOpacity(0),
                                                ],
                                                // stops: [
                                                //   0.0,
                                                //   1.0
                                                // ]
                                              )),
                                        )
                                      ]),
                      ],
                    ),
                  ),
                  InkWell(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //  Text(
                        //   flag ? "Show More >" : "Show Less <",
                        //   style:  TextStyle(color: Colors.blue.shade900, fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        flag ?
                        Column(
                          children: [
                            Text('Show More',style:  TextStyle(color: Colors.blue.shade900, fontSize: 16, fontWeight: FontWeight.bold)),
                            Icon(Icons.keyboard_arrow_down_outlined, color: Colors.blue.shade900,)
                          ],
                        )
                            : Column(
                          children: [
                            Text('Show Less',style:  TextStyle(color: Colors.blue.shade900, fontSize: 16, fontWeight: FontWeight.bold)),
                            Icon(Icons.keyboard_arrow_up_outlined, color: Colors.blue.shade900,)
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 300,),

          ],
        ),
      ),
    );
  }
}
