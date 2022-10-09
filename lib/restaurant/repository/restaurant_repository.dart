import 'package:code_factory_inflearn/common/const/data.dart';
import 'package:code_factory_inflearn/common/dio/dio.dart';
import 'package:code_factory_inflearn/common/model/pagination_params.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_inflearn/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:code_factory_inflearn/common/model/cursor_pagination_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
});

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestuarantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
