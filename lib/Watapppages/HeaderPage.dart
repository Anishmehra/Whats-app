import 'package:flutter/material.dart';
import 'package:watsapppp/Watapppages/chatpage.dart';


class headerPage extends StatefulWidget {
   headerPage({Key? key}) : super(key: key);

  @override
  State<headerPage> createState() => _headerPageState();
}

class _headerPageState extends State<headerPage> with TickerProviderStateMixin {
 late final TabController _tabcontroler;

 @override
  void initState() {
    super.initState();
    _tabcontroler = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WhatsApp",style:TextStyle(
            color: Colors.white
          ),),
          actions: [ 
            popMenu(context)     
          ],
          backgroundColor:Colors.blueGrey[800],
          bottom:TabBar(
            labelColor:  Color.fromARGB(197, 29, 239, 197),
            dividerColor: Colors.blueGrey[800],
            indicatorColor:Color.fromARGB(197, 29, 239, 197) ,
            controller: _tabcontroler,
            labelStyle: TextStyle(fontSize: 15),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            tabs:<Widget> [
            Tab(
              text: "Chats",
            ), 
            Tab(
              text: "Status",
            ), 
            Tab(
              text: "Calls",
            )
          ]),
        ),
        body:TabBarView(  
                    controller: _tabcontroler,
                    children: <Widget>[
                    chatPages(),
                      Center(
                        child: Text("status"),
                      ),
                      Center(
                        child: Text("calls"),
                      ),
                    ],
                  )
                );
              }
            }


Widget popMenu(BuildContext context){
  return PopupMenuButton<String>(
              onSelected: (value){
              },
              color: Colors.blueGrey[800],
               offset:const Offset(0, 50),
               
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              icon: Icon(Icons.more_vert,color: Colors.white,),
              itemBuilder: (BuildContext context){
              return [
                PopupMenuItem<String>(
                child: Text("New group",style: TextStyle(color: Colors.white,fontSize: 16),)
                ), 
                PopupMenuItem<String>(
                child: Text("New broadcast",style: TextStyle(color: Colors.white,fontSize: 16))
                ),
                PopupMenuItem<String>(
                child: Text("Linked devices",style: TextStyle(color: Colors.white,fontSize: 16))
                ),
                PopupMenuItem<String>(
                child: Text("Starred message",style: TextStyle(color: Colors.white,fontSize: 16))
                ),
                PopupMenuItem<String>(
                child: Text("Payments",style: TextStyle(color: Colors.white,fontSize: 16))
                ),
                PopupMenuItem<String>(
                child: Text("Settings",style: TextStyle(color: Colors.white,fontSize: 16))
                )
              ];
            }
          );
        }

