import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
part 'database.g.dart';

class Restaurante extends Table{
  IntColumn get id=>integer().named('id')();
  TextColumn get title=>text().named('title')();
  TextColumn get poster=>text().named('poster')();

}

LazyDatabase abrirConexion(){
  return LazyDatabase(() async{
    final dbFolder=await getApplicationDocumentsDirectory();
    final file=File(p.join(dbFolder.path,'dbPost.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables:[Restaurante])
class AppDatabase extends _$AppDatabase{
  AppDatabase(NativeDatabase nativeDatabase):super(abrirConexion());

  @override
  int get schemaVersion=>1;
  Future<int> insertarRestaurant(RestauranteCompanion restaurantCompanion) async{
    return await into(restaurante).insert(restaurantCompanion);
  }
  Future<List<RestauranteData>> getListado() async{
    return await select(restaurante).get();
  }
  Future<int> eliminarRestaurant(int id) async{
    return await (delete(restaurante)..where((tbl) => tbl.id.equals(id))).go();
  }


}
