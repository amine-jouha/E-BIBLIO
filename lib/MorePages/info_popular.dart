import 'package:ebiblio/MorePages/bookInfos.dart';
import 'package:ebiblio/MorePages/popBookInfos.dart';
import 'package:ebiblio/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/books_card_widget.dart';

class InfoPopular extends StatefulWidget {
  const InfoPopular({Key? key}) : super(key: key);

  @override
  State<InfoPopular> createState() => _InfoPopularState();
}

class _InfoPopularState extends State<InfoPopular> {
  final ScrollController _scrollController = ScrollController();
  HomeProvider? _provider;
  RefreshController _controller1 = RefreshController();

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<HomeProvider>(context, listen: false);
    _provider!.query;
    _provider!.books;
    _provider!.isLoading =true;
    _provider?.getBooks();



    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getBooksApi();
      }
    });

  }
  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 100));
  }

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 800)).then((val) {
      _controller1.refreshCompleted();
      _provider!.query;
      _provider?.getBooks();
      // amine oublie pas ça
//                refresher.sendStatus(RefreshStatus.completed);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Books'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provideer, widget) => NotificationListener<ScrollEndNotification>(

          onNotification: (ScrollNotification notification) {

            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              _getBooksApi();
            }
            return true;

          },
          child: provideer.isLoading!
          ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: LoadingAnimationWidget.threeArchedCircle(
                size: 30, color: Colors.lightBlueAccent,
              ),
            ),
          )
          :SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _controller1,
            onRefresh: _onRefresh,
            footer: ClassicFooter(
              iconPos: IconPosition.top,
              outerBuilder: (child) {
                return Container(
                  width: 80.0,
                  child: Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      size: 30, color: Colors.lightBlueAccent,
                    ),
                  ),
                );
              },
            ),
            onLoading: _onLoading,
            child: Container(
              child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: provideer.books.length,
                itemBuilder: (context, index) {
                  final book = provideer.books[index];
                  return InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => PopBookInfos(
                           title: book.title,
                           image: book.thumbnail,
                           author: book.author,
                           tag:'fous',
                           description: book.description,
                           subtitle: book.subtitle,
                           publishedDate: book.publishedDate,
                           pageCount:book.pageCount,
                           averageRating: book.averageRating
                       ) ));
                    },
                    child: BookWidget(
                        book.title,
                        book.subtitle,
                        book.thumbnail,
                      book.author,
                      book.pageCount,
                      book.description,
                      book.averageRating,
                      book.publishedDate


                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Color(0xffDADADA),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _getBooksApi() {
    _provider?.showLoading();
    _provider?.getBooks();
  }
}
