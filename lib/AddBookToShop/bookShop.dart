import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/MorePages/bookInfos.dart';
import 'package:ebiblio/model/Book_model.dart';
import 'package:ebiblio/model/bookModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../model/userInfo_model.dart';

class BookShop extends StatefulWidget {
  const BookShop({Key? key}) : super(key: key);

  @override
  State<BookShop> createState() => _BookShopState();
}

class _BookShopState extends State<BookShop> {
  User? user = FirebaseAuth.instance.currentUser;

  //notre form key
  final _formKey = GlobalKey<FormState>();
  //modifier le controller
  final TitleEditingController = new TextEditingController();
  final AuthorEditingController = new TextEditingController();
  final DescriptionEditingController = new TextEditingController();
  final BookDateEditingController = new TextEditingController();
  final PageEditingController = new TextEditingController();
  final PriceEditingController = new TextEditingController();
  String? _currentSelectedValue;

  var _currencies = [
    "New",
    "First Hand",
    "Little Damage",
    "Damaged",
  ];

  @override
  Widget build(BuildContext context) {
    final TitleBook = TextFormField(
      // style: TextStyle(height: 0.5),
      autofocus: false,
      controller: TitleEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3}$');
        if(value!.isEmpty)
        {
          return ('Title connot be empty!');
        }
        if(!regex.hasMatch(value)) {
          return ('Enter a Correct Title (Min. 3 Character)');
        }
        return null;
      },
      onSaved: (value) {
        TitleEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.book,),
          hintText: 'Title',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      // maxLength: 15,
    );
    //pour author name
    final authorName = TextFormField(
      autofocus: false,
      controller: AuthorEditingController,
      keyboardType: TextInputType.name,
      validator: (value)
      {
        if(value!.isEmpty) {
          return ('Entrer votre Email');
        }
        //reg expression for email validation
        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value))
        {
          return ('Entrez un Email Valid!');
        }
        return null;
      },
      onSaved: (value) {
        AuthorEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.user),
          hintText: 'Author Name',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    // for Book Date
    final BookDate = TextFormField(
      autofocus: false,
      controller: BookDateEditingController,
      keyboardType: TextInputType.datetime,
      validator: (value)
      {
        if(value!.isEmpty) {
          return ('Entrer votre Email');
        }
        //reg expression for email validation
        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value))
        {
          return ('Entrez un Email Valid!');
        }
        return null;
      },
      onSaved: (value) {
        BookDateEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.calendar),
          hintText: 'dd/mm/yyyy',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    //for page number
    final PageNum = TextFormField(
      autofocus: false,
      controller: PageEditingController,
      keyboardType: TextInputType.number,
      validator: (value)
      {
        if(value!.isEmpty) {
          return ('Enter Number of Pages!');
        }
        //reg expression for email validation
        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value))
        {
          return ('Enter a valid Number!');
        }
        return null;
      },
      onSaved: (value) {
        PageEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.book_reader),
          hintText: 'Total Num Page',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    //for prices
    final PriceBook = TextFormField(
      autofocus: false,
      controller: PriceEditingController,
      keyboardType: TextInputType.number,
      validator: (value)
      {
        if(value!.isEmpty) {
          return ('Enter a Price');
        }
        //reg expression for email validation
        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value))
        {
          return ('Enter a valid Price!');
        }
        return null;
      },
      onSaved: (value) {
        PriceEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.money_check),
          hintText: 'Price Book',
          helperText: 'xx.xx Not xx,xx',
          suffixText: '\$',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    //Pour le Description
    final Description = TextFormField(
      // style: TextStyle(height: 0.5),
      autofocus: false,
      maxLines: 15,
      maxLength: 1400,
      minLines: 6,
      controller: DescriptionEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return ('Give a Description of book');
        }
        if(!regex.hasMatch(value)) {
          return ('Entrer a Valid Description (Min. 6 Lines)');
        }
        return null;
      },
      onSaved: (value) {
        DescriptionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Padding(
            padding: const EdgeInsets.only(bottom: 97),
            child: Icon(LineAwesomeIcons.envelope, size: 24,),
          ),
          hintText: 'Description of Book',
          // isDense: true,
          // contentPadding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      // maxLength: 15,
    );
    // pour la condition du book
    final Condition = FormField(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.redAccent, fontSize: 14.0),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Condition Book'),
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
    // boutton submit
    final SubmitButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      color: Colors.brown,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async{
          await AddBookToShop(
                  TitleEditingController.text,
                  AuthorEditingController.text,
                  PageEditingController.text,
                  BookDateEditingController.text,
                  PriceEditingController.text,
                  _currentSelectedValue!,
                  DescriptionEditingController.text
              );
        },
        child: Text(
          'Submit Book',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book To Shop'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                    child: Text('Infos Book', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
                ),
                SizedBox(height: 15,),
                TitleBook,
                SizedBox(height: 15,),
                authorName,
                SizedBox(height: 15,),
                PageNum,
                SizedBox(height: 15,),
                BookDate,
                SizedBox(height: 15,),
                PriceBook,
                SizedBox(height: 15,),
                Condition,
                SizedBox(height: 15,),
                Description,
                SizedBox(height: 25,),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Add Images', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      Text('5 images max', style: TextStyle(fontSize: 10, color: Colors.grey.shade700),),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Icon(LineAwesomeIcons.plus, color: Colors.grey.shade600,)),
                          ),
                          SizedBox(width: 5,),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                SubmitButton,
                SizedBox(height: 25,),


              ],
            ),
          ),
        ),
      )
    );
  }
  AddBookToShop(
      String title,String author,String numPage,String dateBook,String price,String condition,String description) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    BookFormShop bookFormShop = BookFormShop();

    bookFormShop.uid = user!.uid;
    bookFormShop.title = title;
    bookFormShop.author = author;
    bookFormShop.numPage = numPage;
    bookFormShop.dateBook = dateBook;
    bookFormShop.price = price;
    bookFormShop.condition = condition;
    bookFormShop.description = description;





    await CircularProgressIndicator();
    Navigator.of(context).pop();
    await firebaseFirestore.collection('BookFormShop').doc(user!.uid + bookFormShop.price.toString()).set(bookFormShop.toMap());
    Fluttertoast.showToast(msg: 'Book Added successfully ${user!.displayName}');





    // FirebaseFirestore.instance.collection('UserInfo').doc();
    //  final bookModel = UserInfos(
    //    uid : user!.uid,
    //    ville : ville,
    //    type : type
    //  );
    // await _auth.createUserWithEmailAndPassword(email: email, password: password)
    //     .then((value) => {postDetailsToFirestore()})
    //     .catchError((e) {
    //   Fluttertoast.showToast(msg: e!.message);
    // });


  }
}


