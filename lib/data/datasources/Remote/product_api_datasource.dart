import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import 'dto/fakestore_product_dto.dart';
// import 'dto/category_dto.dart';
import 'mappers/product_mapper.dart';
// import 'mappers/category_mapper.dart';

/// Remote API data source for products
/// Handles HTTP requests to fetch products from remote API
abstract class ProductApiDataSource {

  Future<List<FakeStoreProductDto>> getProducts();

}



