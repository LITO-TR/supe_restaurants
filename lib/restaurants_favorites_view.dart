import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:supe_restaurants/database/database.dart';
import 'package:drift/drift.dart' as dr;

class RestaurantsFavoritesView extends StatefulWidget {
  const RestaurantsFavoritesView({Key? key}) : super(key: key);

  @override
  State<RestaurantsFavoritesView> createState() => _RestaurantsFavoritesViewState();
}

class _RestaurantsFavoritesViewState extends State<RestaurantsFavoritesView> {



  @override
  Widget build(BuildContext context) {
    final database = AppDatabase(NativeDatabase.memory());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(
            Icons.chevron_left
        ),
        ),
        title: Text('Listado de Post'),
      ),

      body: FutureBuilder<List<RestauranteData>>(
        future: database.getListado(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RestauranteData>? postList = snapshot.data;
            return ListView.builder(
                itemCount: postList!.length,
                itemBuilder: (context, index) {
                  RestauranteData postData = postList[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    key: ValueKey<int>(postData.id),
                    onDismissed: (DismissDirection direction) async {
                      await database.eliminarRestaurant(postData.id);
                      setState(() {
                        postList.remove(postList[index]);
                      });
                    },


                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width*1,
                        child:Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Codigo: " +
                                        postList[index].id.toString()),
                                    Text("Title: " + postList[index].title),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }


  }

