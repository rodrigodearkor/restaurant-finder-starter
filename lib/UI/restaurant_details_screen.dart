import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favorite_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/image_container.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle.copyWith(fontSize: 18),
                ),
                Text(restaurant.address,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w100)),
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavoriteButton(context),    
        ],
      ),
    );
  }

  Widget _buildBanner() => ImageContainer(
        height: 200,
        url: restaurant.imageUrl,
      );

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(
            width: 40,
          ),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favorities$,
      initialData: bloc.favorities,
      builder: (context, snapshot) {
        List<Restaurant> favorities =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favorities
                : snapshot.data;

        bool isFavorite = favorities.contains(restaurant);

        return FlatButton.icon(
          onPressed: () => bloc.toggleRestaurant(restaurant),
          textColor: isFavorite ? Theme.of(context).accentColor : null,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favorite'),
        );
      },
    );
  }
}
