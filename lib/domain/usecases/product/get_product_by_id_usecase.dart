
import '../../../core/models/product_detail.dart';
import '../../interfaces/repositories/product_repository.dart';

class GetProductsByIdUseCase {
  // final GeneralProductRepository repository;
  final ProductRepository repository;

  GetProductsByIdUseCase(this.repository);

  Future<ProductDetail> execute(int id) async {
    return await repository.getProductDetail(id);
  }
}