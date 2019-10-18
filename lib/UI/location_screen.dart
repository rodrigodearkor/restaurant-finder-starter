import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you want to eat?'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
        stream: bloc.locations$,
        builder: (context, snapshot) {
          final results = snapshot.data;

          if (results == null) {
            return Center(
              child: Text('Enter a location'),
            );
          }

          if (results.isEmpty) {
            return Center(
              child: Text('No results'),
            );
          }

          return _buildSeachResults(results);
        });
  }

  Widget _buildSeachResults(List<Location> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);
            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}
