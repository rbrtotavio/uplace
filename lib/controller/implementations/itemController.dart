import 'package:uplace/application/services/implementations/itemService.dart';
import 'package:uplace/application/services/implementations/sellerService.dart';
import 'package:uplace/controller/baseController.dart';
import 'package:uplace/controller/handling/response.dart';
import 'package:uplace/models/item.dart';

class ItemController extends BaseController {
  final ItemService _itemService = ItemService();

  ItemController();

  Future<Response> getSearchedItems(String query) async {
    var validate = await validateLogedUser();
    if (!validate) {
      return awnser(null);
    }
    return awnser(await _itemService.getSearchedItems(query));
  }
}
