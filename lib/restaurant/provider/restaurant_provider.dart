import 'package:code_factory_inflearn/common/model/cursor_pagination_model.dart';
import 'package:code_factory_inflearn/common/provider/pagination_provider.dart';
import 'package:code_factory_inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestuarantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return RestaurantStateNotifier(repository: repository);
});

class RestaurantStateNotifier
    extends PaginationProvider<RestuarantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  Future<void> getDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final res = await repository.getRestaurantDetail(id: id);

    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestuarantModel>[
          ...pState.data,
          res,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestuarantModel>((e) => e.id == id ? res : e)
            .toList(),
      );
    }
  }
}
