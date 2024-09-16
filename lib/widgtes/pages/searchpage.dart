import 'package:flutter/material.dart';
import 'package:uplace/controller/implementations/itemController.dart';
import 'package:uplace/controller/implementations/sellerController.dart';
import 'package:uplace/models/seller.dart';
import 'package:uplace/widgtes/components/category_menu.dart';
import 'package:uplace/widgtes/components/seller_card.dart';
import 'package:uplace/widgtes/components/utils/error_alert.dart';
import 'package:uplace/widgtes/themes/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ItemController _itemController = ItemController();
  get sellerCards => null;

  @override
  void initState() {
    super.initState();
  }

  String teste = "";
  Widget searchField() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: "Nome da loja",
              labelStyle: TextStyle(fontSize: 18, fontFamily: 'clarissans'),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                searchItem(value);
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueUplace,
        leading: Container(),
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: AppColors.greenUplace),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: AppColors.greenUplace,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchField(),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categorias",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Proximidade",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Local",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void searchItem(query) async {
    var items = await _itemController.getSearchedItems(query);
    print(items![0]);
    print(items != null ? items.length : 0);
  }

  Future<List<Seller>?> getFoodsResults() async {}

  Future<List<Seller>?> getProductResults() async {}

  Future<List<Seller>?> getServiceResults() async {}
}
