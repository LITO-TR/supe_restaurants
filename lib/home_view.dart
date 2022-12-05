import 'dart:convert';
import 'package:drift/native.dart';
import 'package:supe_restaurants/database/database.dart';
import 'package:supe_restaurants/api/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:supe_restaurants/restaurants_favorites_view.dart';
import 'package:supe_restaurants/sign-in_view.dart';
import 'package:drift/drift.dart' as dr;


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  static late Future<List<Restaurant>> restaurants;
  String dataId = '';


  @override
  void initState() {
    // TODO: implement initState
    restaurants = getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final database= AppDatabase(NativeDatabase.memory());

    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurants"),
        actions: [
          IconButton(onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInView()), (route) => false);
          },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,MaterialPageRoute(builder: (context) => RestaurantsFavoritesView()));
        },

        child: const Icon(Icons.navigation),
      ),
      body:
      FutureBuilder<List<Restaurant>>(
          future: restaurants,
          builder: (context, snap) {
            if(snap.hasData){
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    var rest = snap.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: ListTile(
                          leading:   CircleAvatar(
                            backgroundImage: NetworkImage(rest.poster),
                          ),
                          title: Text(rest.title),
                          trailing: IconButton(onPressed: (){
                            database.insertarRestaurant(
                                RestauranteCompanion(
                                id: dr.Value(rest.id),
                                title: dr.Value(rest.title),
                                poster: dr.Value(rest.poster)
                                )).then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content:
                                  Text("Guardado")));
                            });

                          }, icon: Icon(Icons.favorite)),

                        ),

                      ),
                    );

                  });
            }
            else if(snap.hasError) {
              return  Center(
                child: Text("error ${snap.error}"),
              );

            }
            return const Center(child: CircularProgressIndicator());
          }


      ),
    );
  }
  Future<List<Restaurant>> getRestaurants() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("dataId");
    print(val);
    final res = await http.get(Uri.parse("https://probable-knowledgeable-zoo.glitch.me/restaurants")); //text

    final list = List.from(jsonDecode(res.body));
    List<Restaurant> restaurants = [];
    for (var element in list) {
      final Restaurant product = Restaurant.fromJson(element);
      restaurants.add(product);
    }

    return restaurants;
  }



}
