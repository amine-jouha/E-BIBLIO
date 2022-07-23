import'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BookShop extends StatefulWidget {
  const BookShop({Key? key}) : super(key: key);

  @override
  State<BookShop> createState() => _BookShopState();
}

class _BookShopState extends State<BookShop> {

  //notre form key
  final _formKey = GlobalKey<FormState>();
  //modifier le controller
  final TitleEditingController = new TextEditingController();
  final AuthorEditingController = new TextEditingController();
  final DescriptionEditingController = new TextEditingController();
  final BookDateEditingController = new TextEditingController();
  final PageEditingController = new TextEditingController();
  final PriceEditingController = new TextEditingController();

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
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
        PageEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.book_reader),
          hintText: 'Total Num Page',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
        PriceEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:Icon(LineAwesomeIcons.money_check),
          hintText: 'Price Book',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          return ('Metez un msg');
        }
        if(!regex.hasMatch(value)) {
          return ('Entrer un Message Valid(Min. 6 Character)');
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
          hintText: 'Description',
          // isDense: true,
          // contentPadding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      // maxLength: 15,
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
                Description,
                SizedBox(height: 0,),
              ],
            ),
          ),
        ),
      )
    );
  }
}


