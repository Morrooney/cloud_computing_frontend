import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThesisFiles extends StatefulWidget {


  @override
  _ThesisFilesState createState() => _ThesisFilesState();
}

class _ThesisFilesState extends State<ThesisFiles> {

  bool ordiniOttenuti = true;

  /*
  List<BookInPurchase> books_in_the_purchases;

  @override
  Future<void> initState() {
    _getPurchases();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return ordiniOttenuti? new ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SingleCartFile();
        }
    ) : Center(child:CircularProgressIndicator());
  }
  /*

  Future<void> _getPurchases() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("id");
    Model.sharedInstance.showUserPurchases(id).then((result){
      List<BookInPurchase> ret = new List<BookInPurchase>();
      for(Purchase purchase in result)
      {
        for(BookInPurchase bookInPurchase in purchase.booksInPurchase)
        {
          ret.add(bookInPurchase);
        }
      }
      setState((){
        ordiniOttenuti = true;
        books_in_the_purchases = ret;
      });
    });
  }
*/
}

class SingleCartFile extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Card(
        semanticContainer: true,
        margin: EdgeInsets.fromLTRB(6.0,10, 6.0, 4.0),
        elevation: 3,
        child: ListTile(
// ============================== LEADING SECTION ================================
          leading: InkWell(
            borderRadius: BorderRadius.circular(20) ,
            onTap: (){},
            child: new IconButton(
              icon: new Icon(CupertinoIcons.doc_text),
              onPressed: null,
            ),
          ),
//======================================== title section ==============================
          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text('nome file'),
          ),
// =============================== subtitle section ================================
          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(
              "data",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),

          trailing:new FittedBox(
            fit: BoxFit.fill,
            child: new Row(
              children: <Widget>[
                new Text(
                  "size",
                  //style: TextStyle(),
                ),
                Padding(padding: const EdgeInsets.only(left: 5.0,right: 2.0)),
                new IconButton(
                  splashRadius: 20,
                  icon: new Icon(Icons.download_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}



