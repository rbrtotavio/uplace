import 'package:uplace/application/services/implementations/consumerService.dart';
import 'package:uplace/application/services/implementations/sellerService.dart';
import 'package:uplace/controller/baseController.dart';
import 'package:uplace/controller/handling/response.dart';

class ConsumerController extends BaseController {
  final ConsumerService _consumerService = ConsumerService();
  // final SellerService _sellerService = SellerService();

  ConsumerController();

  Future<Response> getConsumer() async {
    var validate = await validateLogedUser();
    if (!validate) {
      return awnser(null);
    }
    return awnser(await _consumerService.getConsumer());
  }

  // void Migrate() async {
  //   _sellerService.migrate();
  // }
}
