import 'package:flutter/material.dart';
import 'package:scopemodelproject/data/scope_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
  
class Home extends StatefulWidget {
  @override
  MyHomeState createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<Home> with SingleTickerProviderStateMixin {
  NewsModel newsModel = NewsModel();

  
  
  

  @override
  void initState() {
    super.initState();
    newsModel.getId();
    
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NewsModel>(
        model: newsModel,
        child: ScopedModelDescendant<NewsModel>(
            builder: (BuildContext context, Widget child, NewsModel model) {
          print("here => ${model.newsList}");
          return Scaffold(
            appBar: AppBar(
              title: Text("NEWS ITEMS",style: TextStyle(fontSize: 30, fontStyle: FontStyle.normal,color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            body:  model.isLoading
                ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1,0.5,0.7,0.9],
                      colors: [
                        Colors.grey[400],
                        Colors.grey[400],
                        Colors.grey[500],
                        Colors.grey[600],
                      ]
                    )
                  ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.newsList.length,
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(
                          onTap: (){
                            print("tap");
                            
                          },
                          child: Center(
                          child:Container(
                             width: 300,
                            height: 402,
                             child:Column(
                               children:<Widget>[
                                 Center(child:
                            Container( 
                              width: 300,
                              height: 250,
                              
                            child: Card(
                            margin: EdgeInsets.all(10),
                            color: Colors.amber[700],
                            child:Column(
                            children: <Widget>[
                            Center(child:
                            Text(model.newsList[index].title,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black)),),
                            
                            ],
                            
                            ),
                          ),),),
                          Padding(padding: EdgeInsets.all(1),),
                          Container(
                            width: 300,
                            height: 150,
                           child:Card(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                 Text("TYPE- ${model.newsList[index].type.toUpperCase()}",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal,color: Colors.black,decoration: TextDecoration.underline),),
                            Padding(padding: EdgeInsets.all(3),),
                            Text("BY- ${model.newsList[index].by.toUpperCase()}",style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal,color: Colors.black,decoration: TextDecoration.underline)),
                            Padding(padding: EdgeInsets.all(4),),
                            RaisedButton(
                              color: Colors.black,
                              child: Text("READ MORE",style: TextStyle(fontSize: 15,fontStyle: FontStyle.normal,color: Colors.white,decoration: TextDecoration.underline)), onPressed: (){_launchUrl(model.newsList[index].url);},
                            )
                              ],
                            )
                          ),),
                          ],),),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        }));
  }
 _launchUrl(url) async {
   if (await canLaunch(url)) {
     await launch(url);
   } else {
     throw 'could not launch $url';
   }
 }
  
}