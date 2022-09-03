import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../MorePages/popBookInfos.dart';

class BookWidget extends StatefulWidget {
  final String? _title,
      _subtitle,
      _thumbnail,
      _author,
      pageCount,
      description,
      averageRating,
      publishedDate

  ;

  BookWidget(
      this._title,
      this._subtitle,
      this._thumbnail,
      this._author,
      this.pageCount,
      this.description,
      this.averageRating,
      this.publishedDate,
      );

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          // elevation: 3,
          child: ListTile(
            onTap: () {
              // ignore: deprecated_member_use
              Navigator.push(context, MaterialPageRoute(builder: (context) => PopBookInfos(
                  title: widget._title,
                  image: widget._thumbnail,
                  author: widget._author,
                  tag:'fous',
                  description: widget.description,
                  subtitle: widget._subtitle,
                  publishedDate: widget.publishedDate,
                  pageCount:widget.pageCount,
                  averageRating: widget.averageRating

              )));
              // print(pdItems[index].url.length);
            },
            title: Text(widget._title ?? '-',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
            // leading: Image.network(widget._thumbnail ?? "",),
            leading: Container(
              height: 100,
              width: 50,
              child: CachedNetworkImage(
                imageUrl: widget._thumbnail ?? "",
              ),
            ),
            trailing:Icon(LineAwesomeIcons.angle_right, color: Colors.blue.shade900,),
            subtitle: Text('Auteur: (${widget._author ?? '-'})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),

          ),
        );
  }

}
