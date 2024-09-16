import 'package:uplace/application/services/implementations/itemService.dart';
import 'package:uplace/application/services/implementations/sellerService.dart';
import 'package:uplace/controller/baseController.dart';
import 'package:uplace/controller/handling/response.dart';
import 'package:uplace/models/item.dart';

class ItemController extends BaseController {
  final ItemService _itemService = ItemService();

  ItemController();

  Future<List<Item>?> getSearchedItems(String query) {
    var items = _itemService.getSearchedItems(query);
    return items;
  }
}
