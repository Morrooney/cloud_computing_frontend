import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import '../../model/objects/entity/thesis.dart';


class ThesesCards extends StatefulWidget {


  @override
  _ThesesCardsState createState() => _ThesesCardsState();
}

class _ThesesCardsState extends State<ThesesCards> {

  bool tesiOttenute = false;


  late List<Thesis> _docentTheses;

  @override
  void initState() {
    _getDocentThesis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return tesiOttenute? new ListView.builder(
        itemCount: _docentTheses.length,
        itemBuilder: (context, index) {
          return SingleCardThesis(thesis: _docentTheses[index],);
        }
    ) : Center(child:CircularProgressIndicator());
  }


  Future<void> _getDocentThesis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String docentEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.showDocentThesis(docentEmail).then((result){
      setState((){
        tesiOttenute = true;
        _docentTheses = result!;
      });
    });
  }
}

class SingleCardThesis extends StatefulWidget {

  Thesis thesis;

  SingleCardThesis({required this.thesis});

  @override
  State<SingleCardThesis> createState() => _SingleCardThesisState();
}

class _SingleCardThesisState extends State<SingleCardThesis> {

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
            child: new Text('${widget.thesis.title}'),
          ),
// =============================== subtitle section ================================
          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(
              "${widget.thesis.thesisStudent.name} "+"${widget.thesis.thesisStudent.surname}",
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
              Navigator.of(context).pushNamed(
                  ThesisDetails.route,
                  arguments: widget.thesis.toJson(),
              );
            },
          ),
        ),
      ),
    );
  }
}






