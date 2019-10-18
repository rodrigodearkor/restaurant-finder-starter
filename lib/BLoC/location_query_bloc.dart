import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class LocationQueryBloc extends Bloc {

  final _client = ZomatoClient();
  final _$locations$ = StreamController<List<Location>>();

  void submitQuery(String query) async {
    
    final results = await _client.fetchLocations(query);
    _$locations$.sink.add(results);
  }

  Stream<List<Location>> get locations$ => _$locations$.stream;

  @override
  void dispose() {
    _$locations$.close();
  }
}