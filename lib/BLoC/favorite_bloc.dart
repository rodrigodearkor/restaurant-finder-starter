import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class FavoriteBloc extends Bloc {

  var _restaurants = <Restaurant>[];
  final _$restaurants$ = StreamController<List<Restaurant>>.broadcast();

  List<Restaurant> get favorities => _restaurants;
  Stream<List<Restaurant>> get favorities$ => _$restaurants$.stream;

  void toggleRestaurant(Restaurant restaurant) {

    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _$restaurants$.sink.add(_restaurants);
  }

  @override
  void dispose() {
    _$restaurants$.close();
  }
}