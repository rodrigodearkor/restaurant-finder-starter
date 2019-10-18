import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class RestaurantBloc extends Bloc {

  final Location location;
  final _client = ZomatoClient();
  final _$restaurants$ = StreamController<List<Restaurant>>();

  RestaurantBloc(this.location);

  // Stream
  Stream<List<Restaurant>> get restaurants$ => _$restaurants$.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _$restaurants$.sink.add(results);
  }

  @override
  void dispose() {
    _$restaurants$.close();
  }

}