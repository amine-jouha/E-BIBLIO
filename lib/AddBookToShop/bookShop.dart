import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebiblio/model/Book_model.dart';
import 'package:ebiblio/providers/addBook_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../model/userInfo_model.dart';
import '../model/user_model.dart';

class BookShop extends StatefulWidget {
  const BookShop({Key? key}) : super(key: key);

  @override
  State<BookShop> createState() => _BookShopState();
}

class _BookShopState extends State<BookShop> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserInfos userInfos = UserInfos();
  addBookProvider? _addBookPro;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    FirebaseFirestore.instance.collection('UserInfo').doc(user!.uid).get().then((value) {
      this.userInfos = UserInfos.fromMap(value.data());
      setState(() {});
    });

    // FirebaseFirestore.instance.collection('UserInfo').doc(user!.uid).get().then((value) {
    //   userInfos.bookInShop;
    //   setState(() {});
    // });

    userInfos.bookInShop;

    _addBookPro = Provider.of<addBookProvider>(context, listen: false);
    _addBookPro!.num;
  }





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
  bool isVisible = false;

  var _currencies = [
    "New",
    "First Hand",
    "Little Damage",
    "Damaged",
  ];

  // PlatformFile? pickedFile;
  //
  //
  // Future selectFile() async{
  //   final result = await FilePicker.platform.pickFiles();
  //   if(result == null) return;
  //
  //   setState(() {
  //     pickedFile = result.files.first;
  //   });
  //
  // }


  // List<Asset> images = <Asset>[];
  // Asset? lastPic;

  // Future<void> pickImages() async {
  //   List<Asset> resultList = <Asset>[];
  //   print('cest bon');
  //
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 5,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       materialOptions: MaterialOptions(
  //         actionBarTitle: "e-Bilio Pick Images",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  //
  //
  //   setState(() {
  //     images = resultList;
  //     if (images.length == 0) {
  //       isVisible = false;
  //     }
  //
  //   });
  // }

  List<XFile> selectedImages = [];
  // FirebaseStorage storage = FirebaseStorage.instance;
  // Reference storageRef = FirebaseStorage.instance.ref();
  List<String> imgURL = [];

  Future<void> pickImages() async {
    final pickedFileList = await ImagePicker().pickMultiImage();
    if (pickedFileList != null) {
      setState(() {
        selectedImages = pickedFileList;
        if (selectedImages.length == 0) {
          isVisible = false;
        }
      });
    }
  }

  // uploadFile() async {
  //   var imageFile = FirebaseStorage.instance.ref().child('/${loggedInUser.uid.toString()}');
  //   UploadTask task = imageFile.putFile(file!);
  //   TaskSnapshot snapshot = await task;
  //   //for downloading
  //   url = await snapshot.ref.getDownloadURL();
  //   print(url);
  //   print('ici');
  //   print(imageFile.name);
  // }
  //
  var url ='';

  Future<void> uploadSelectedImages() async {
    print("--------------------------------");
    print(userInfos.bookInShop!);
    print("--------------------------------");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    for (var i = 0; i < selectedImages.length; i++) {
      final ref = FirebaseStorage.instance.ref().child('book${loggedInUser.uid.toString()}/book${userInfos.bookInShop!.toString()}/$i${loggedInUser.userName.toString()}');

      // await ref.putFile(File(selectedImages[i].path));
      UploadTask task = ref.putFile(File(selectedImages[i].path));
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      print(url);
    }

    await firebaseFirestore.collection('UserInfo').doc(user!.uid).update({"bookInShop" : userInfos.bookInShop! + 1}).then((value)
    => print("successfuly updated! bro"),
        onError: (e) => print('Error Updating Document $e')
    );
    // userInfos.bookInShop = (userInfos.bookInShop!) + 1;
    print(userInfos.bookInShop);

  }








  @override
  Widget build(BuildContext context) {

    final TitleBook = TextFormField(
      // style: TextStyle(height: 0.5),
      autofocus: false,
      controller: TitleEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
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
          return ('Enter Name Author');
        }
        //reg expression for email validation
        if(!RegExp(r'^.{3,}$').hasMatch(value))
        {
          return ('Enter a Valid Name!');
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
          return ('Entrer date Book');
        }
        //reg expression for email validation
        if(!RegExp(r'^.{6,}$').hasMatch(value))
        {
          return ('Enter a Valid Date!');
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
        if(!RegExp(r'^\d+(,\d{1,2})?$').hasMatch(value))
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
        if(!RegExp(r'^\d+(,\d{1,2})?$').hasMatch(value))
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
                          // Container(
                          //   height: 60,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10)
                          //   ),
                          //   child: pickedFile != null
                          //         ? ClipRRect(
                          //           borderRadius: BorderRadius.circular(10),
                          //           child: Image.file(
                          //                 File(pickedFile!.path!),
                          //                 fit: BoxFit.cover,
                          //               ),
                          //                     )
                          //         : Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          // ),
                          // SizedBox(width: 5,),
                          // Container(
                          //   height: 60,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10)
                          //   ),
                          //   child: Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          // ),
                          // SizedBox(width: 5,),
                          // Container(
                          //   height: 60,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10)
                          //   ),
                          //   child: Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                          // ),
                          Visibility(
                            visible: isVisible,
                            child: Container(
                              height: 80,
                              width: 260,
                              child: ListView.builder(
                                  itemCount: selectedImages.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                     final asset = selectedImages[index];
                                    print('***********');
                                    print(asset);
                                        return Row(
                                          children: [
                                            Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey),
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: selectedImages != []
                                                         ? ClipRRect(
                                                              borderRadius: BorderRadius.circular(10),
                                                              // child: AssetThumb(asset: asset, width: 60, height: 60, )
                                                              child: Image(image: XFileImage(asset), fit: BoxFit.fill,),
                                                         )
                                                         : Center(child: Icon(LineAwesomeIcons.image_1, color: Colors.grey,)),
                                              ),
                                            SizedBox(width: 5,)
                                          ],
                                        );
                                  }
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImages();

                              setState(() {
                                isVisible = true;
                              });
                            },
                            child: selectedImages.length == 5
                            ? Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    // child: AssetThumb(asset: selectedImages[4], width: 60, height: 60, )
                                    child: Image(image: XFileImage(selectedImages[4]), fit: BoxFit.fill,)
                                )
                            )
                            : Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Icon(LineAwesomeIcons.plus, color: Colors.grey.shade600,)),
                            ),
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
  AddBookToShop(String title,String author,String numPage,String dateBook,String price,String condition,String description) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    BookFormShop bookFormShop = BookFormShop();
    if (_formKey.currentState!.validate()) {


    bookFormShop.uid = user!.uid;
    bookFormShop.title = title;
    bookFormShop.author = author;
    bookFormShop.numPage = numPage;
    bookFormShop.dateBook = dateBook;
    bookFormShop.price = price;
    bookFormShop.condition = condition;
    bookFormShop.description = description;

    uploadSelectedImages();








    Navigator.of(context).pop();

      // await firebaseFirestore.collection('BookFormShop').doc(
      //     user!.uid + bookFormShop.price.toString()).set(bookFormShop.toMap());

    await firebaseFirestore.collection('BookFormShop').doc(
        user!.uid + userInfos.bookInShop.toString()).set(bookFormShop.toMap());

      Fluttertoast.showToast(
          msg: 'Book Added successfully ${user!.displayName ?? loggedInUser.userName}, wait for 5min');
    }


  }
}



