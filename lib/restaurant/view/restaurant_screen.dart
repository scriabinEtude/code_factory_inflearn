import 'package:code_factory_inflearn/common/const/data.dart';
import 'package:code_factory_inflearn/common/dio/dio.dart';
import 'package:code_factory_inflearn/common/model/cursor_pagination_model.dart';
import 'package:code_factory_inflearn/restaurant/component/restaurant_card.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:code_factory_inflearn/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:code_factory_inflearn/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('a마지막 데이터'),
              ),
            );
          }

          final pItem = cp.data[index];
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
