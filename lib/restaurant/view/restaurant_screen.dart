import 'package:code_factory_inflearn/common/component/pagination_list_view.dart';
import 'package:code_factory_inflearn/restaurant/component/restaurant_card.dart';
import 'package:code_factory_inflearn/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_inflearn/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => RestaurantDetailScreen(
                    id: model.id,
                  )),
            ));
          },
          child: RestaurantCard.fromModel(model: model),
        );
      },
    );
  }
}
