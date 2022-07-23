import 'package:ebiblio/MorePages/bookInfos.dart';
import 'package:ebiblio/exten.dart';
import 'package:ebiblio/pages/data_recomm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'data_SecondHome.dart';

class SeeRecommended extends StatefulWidget {
  const SeeRecommended({Key? key}) : super(key: key);

  @override
  State<SeeRecommended> createState() => _SeeRecommendedState();
}

class _SeeRecommendedState extends State<SeeRecommended> {
  final controller = TextEditingController();
  List<Fictif> pdItems = onFictif;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: CupertinoSearchTextField(
                    controller: controller,
                    onChanged: searchPodcast,
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                ),


              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: pdItems.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 3),
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            // elevation: 3,
                            child: ListTile(
                              onTap: () {
                                // ignore: deprecated_member_use
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookInfos(
                                      title: pdItems[index].title,
                                      image: pdItems[index].imageBook,
                                      tag: 'tagImage$index',
                                      author: pdItems[index].name,

                                )));
                                // print(pdItems[index].url.length);
                              },
                              title: Text(pdItems[index].title.toTitleCase(),
                                // maxLines: 2,
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                              leading: Hero(tag: 'tagImage$index',
                                  child: Image.asset(pdItems[index].imageBook)),
                              trailing:Icon(LineAwesomeIcons.angle_right, color: Colors.blue.shade900,),
                              subtitle: Text('Auteur: (${pdItems[index].name})',
                                  style: TextStyle(fontSize: 13, color: Colors.grey)),
                              contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),

                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },

              ),
            ),
          ),
        ],
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
