import 'package:code_factory_inflearn/common/const/data.dart';
import 'package:code_factory_inflearn/common/dio/dio.dart';
import 'package:code_factory_inflearn/common/model/cursor_pagination_model.dart';
import 'package:code_factory_inflearn/restaurant/component/restaurant_card.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:code_factory_inflearn/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:code_factory_inflearn/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestuarantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final res =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);
    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (_, index) {
          final pItem = data[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => RestaurantDetailScreen(
                      id: pItem.id,
                    )),
              ));
            },
            child: RestaurantCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: ((context, index) {
          return const SizedBox(height: 8);
        }),
      ),
    );
  }
}
