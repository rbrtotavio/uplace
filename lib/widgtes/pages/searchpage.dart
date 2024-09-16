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
              labelText: "Nome do filme",
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
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
        )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
                color: AppColors.greenUplace,
              ))
        ],
      ),
      body: Column(
        children: [
          searchField(),
          CategoryMenu(
            onSelectedCategory: (String category) async {
              switch (category) {
                case "Alimentos":
                  break;
                case "Produtos":
                  break;
                case "Serviços":
                  break;
                default:
              }
              setState(() {});
            },
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<List<Seller>?>(
                      future: sellerCards,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Seller> sellers = snapshot.data!;
                          return Column(
                            children: List.generate(
                              sellers.length,
                              (index) {
                                return SellerCard(seller: sellers[index]);
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // TODO: Adicionar indicacao de erro
                          print('${snapshot.error}');
                        }
                        return CircularProgressIndicator();
                      }),
                ],
              ),
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
