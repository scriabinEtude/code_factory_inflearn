import 'package:code_factory_inflearn/common/layout/default_layout.dart';
import 'package:code_factory_inflearn/product/component/product_card.dart';
import 'package:code_factory_inflearn/restaurant/component/restaurant_card.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<RestaurantDetailModel>(
            future: ref
                .watch(restaurantRepositoryProvider)
                .getRestaurantDetail(id: id),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return CustomScrollView(
                slivers: [
                  renderTop(snapshot.data!),
                  renderLabel(),
                  renderProducts(products: snapshot.data!.products),
                ],
              );
            }));
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          'menu',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          ((context, index) {
            return ProductCard.fromModel(products[index]);
          }),
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop(
    RestaurantDetailModel model,
  ) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
