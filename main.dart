import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: "Corona App",
      debugShowCheckedModeBanner: false,
      home: ThuloCovid(),
    ));

class ThuloCovid extends StatefulWidget {
  @override
  _ThuloCovidState createState() => _ThuloCovidState();
}

class _ThuloCovidState extends State<ThuloCovid> {
  // For Loading Icon
  bool loading = true;
  List lstCountry;

  // Taking Data From
  Future<String> _getWordData() async {
    var response = await http.get("https://brp.com.np/covid/country.php");
    var getData = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        loading = false;
        lstCountry = [getData];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
      _getWordData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getWordData();
              })
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lstCountry == null
                      ? 0
                      : lstCountry[0]["countries_stat"].length,
                  itemBuilder: (context, i) {
                    return listItem(i);
                  })
        ],
      ),
    );
  }

  Widget listItem(int i) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            lstCountry[0]["countries_stat"][i]["country_name"],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstCountry[0]["countries_stat"][i]["active_cases"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'संक्रमित',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstCountry[0]["countries_stat"][i]["deaths"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'मृत्यु',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstCountry[0]["countries_stat"][i]["deaths"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'निको भको',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),

         Card(
           
           elevation: 2,
                    child: Row(
                     children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.orange,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        lstCountry[0]["countries_stat"][i]["new_cases"],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'संक्रमित',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        lstCountry[0]["countries_stat"][i]["new_deaths"],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'नया मृत्यु',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        lstCountry[0]["countries_stat"][i]["active_cases"],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'रहेको',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
         )
      ],
    );
  }
}
