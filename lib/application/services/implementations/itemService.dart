import 'package:uplace/application/services/interfaces/baseService.dart';
import 'package:uplace/models/item.dart';
import 'package:uplace/repository/implementations/firestore/itemFSRepository.dart';
import 'package:uplace/repository/interfaces/itemRepositoryInterface.dart';

class ItemService extends BaseService {
  final ItemRepositoryInterface _itemRepository = ItemFSRepository();

  ItemService();

  Future<List<Item>?> getSellerItems(String sellerId) async {
    var items = await _itemRepository.getSellerItems(sellerId);
    if (items == null || items.isEmpty) {
      setError("Não foi possível obter os itens do vendendor");
      return null;
    }

    return items;
  }

  Future<List<Item>?> getSearchedItems(String query) async {
    var items = await _itemRepository.getSearchedItems(query);

    if (items == null || items.isEmpty) {
      setError("Não foi encontrado itens");
      return null;
    }

    return items;
  }
}
