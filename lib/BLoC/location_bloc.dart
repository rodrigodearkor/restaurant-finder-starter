import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationBloc extends Bloc {

  Location _location;
  Location get selectedLocation => _location;

  final _$location$ = StreamController<Location>();

  Stream<Location> get location$ => _$location$.stream;

  void selectLocation(Location location) {
      _location = location;
      _$location$.sink.add(location);    
  }

  @override
  void dispose() {
    _$location$.close();
  }
}
