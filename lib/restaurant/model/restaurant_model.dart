import 'package:code_factory_inflearn/common/model/model_with_id.dart';
import 'package:code_factory_inflearn/common/util/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestuarantModel implements IModelWithId {
  @override
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestuarantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestuarantModel.fromJson(Map<String, dynamic> json) =>
      _$RestuarantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestuarantModelToJson(this);
}
