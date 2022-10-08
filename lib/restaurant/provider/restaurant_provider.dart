import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:code_factory_inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestuarantModel>>(
        (ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return RestaurantStateNotifier(repository: repository);
});

class RestaurantStateNotifier extends StateNotifier<List<RestuarantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
    state = resp.data;
  }
}
