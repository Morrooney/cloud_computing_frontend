import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThesesCards extends StatefulWidget {


  @override
  _ThesesCardsState createState() => _ThesesCardsState();
}

class _ThesesCardsState extends State<ThesesCards> {

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
          return SingleCardThesis();
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

class SingleCardThesis extends StatelessWidget {



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
          leading: new Icon(
            Icons.book,
            size: 30,
          ),

//======================================== title section ==============================
          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text('nome tesi'),
          ),
// =============================== subtitle section ================================
          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(
              "tesista",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),

          trailing:new IconButton(
            splashRadius: 20,
            icon: new Icon(Icons.arrow_forward),
            onPressed: (){
              Navigator.of(context).pushNamed(ThesisDetails.route);
            },
          ),
        ),
      ),
    );
  }
}



