import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurant.dart';

import '../detail/detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant App'),
        ),
        body: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              final Restaurant restaurants = restaurantFromJson(snapshot.data);
              if (restaurants.restaurants.isEmpty) {
                return const Center(child: Text('No restaurants data available'));
              } else {
                return ListView.builder(
                  itemCount: restaurants.restaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantItem(
                        context, restaurants.restaurants[index]);
                  },
                );
              }
            }));
  }

  Widget _buildRestaurantItem(
      BuildContext context, RestaurantElement restaurant) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              restaurant.pictureId,
              width: 100,
              errorBuilder: (ctx, error, _) =>
                  const Center(child: Icon(Icons.error)),
            )),
        title: Text(restaurant.name),
        subtitle: Row(
          children: <Widget>[
            const Icon(Icons.star, color: Colors.yellow),
            const SizedBox(width: 5),
            // Add a little spacing between the star icon and the text
            Text(restaurant.rating.toString()),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        });
  }
}
