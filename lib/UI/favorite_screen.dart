import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favorite_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder(
        stream: bloc.favorities$,
        initialData: bloc.favorities,
        builder: (context, snapshot) {
          //
          List<Restaurant> restaurants =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favorities
                  : snapshot.data;

          if (restaurants?.isEmpty ?? true) {
            return Center(
              child: Text('No Favorites'),
            );
          }

          return ListView.separated(
            itemCount: restaurants.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) => RestaurantTile(
              restaurant: restaurants[index],
            ),
          );
        },
      ),
    );
  }
}
