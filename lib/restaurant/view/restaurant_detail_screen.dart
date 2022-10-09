import 'package:code_factory_inflearn/common/layout/default_layout.dart';
import 'package:code_factory_inflearn/product/component/product_card.dart';
import 'package:code_factory_inflearn/rating/component/rating_card.dart';
import 'package:code_factory_inflearn/restaurant/component/restaurant_card.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:code_factory_inflearn/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                avatarImage: AssetImage('asset/img/logo/codefactory_logo.png'),
                images: [],
                rating: 4,
                email: 'jc@codefactory.ai',
                content: 'delicious',
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
              3,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 5,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )),
        ),
      ),
    );
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
    RestuarantModel model,
  ) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
