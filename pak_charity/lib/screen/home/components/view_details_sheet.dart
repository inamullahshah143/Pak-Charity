import 'package:flutter/material.dart';
class ViewDetailSheet extends StatelessWidget {
  const ViewDetailSheet({Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.filter_1),
                  onPressed: () {
                    // Do something
                  }
                ),
                expandedHeight: 220.0,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 50,
                backgroundColor: Colors.pink,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                      fit: BoxFit.cover,
                    )
                ),
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate(_buildList(50))
              ),
            ],
          ),
        
      );
    }
  
    List _buildList(int count) {
      List<Widget> listItems = List();
  
      for (int i = 0; i < count; i++) {
        listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
            child: new Text(
                'Item ${i.toString()}',
                style: new TextStyle(fontSize: 25.0)
            )
        ));
      }
  
      return listItems;
    }
  }