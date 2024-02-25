import 'package:flutter/material.dart';
import 'package:uplace/widgtes/components/navigation_bar.dart';
import 'package:uplace/widgtes/components/product_card.dart';
import 'package:uplace/widgtes/routes/routes.dart';
import 'package:uplace/widgtes/themes/colors.dart';
import 'package:uplace/widgtes/components/ImageCarousel.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.title});

  final String title;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: AppColors.blueUplace,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
          Expanded(
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      RoutesFunctions.gotoHomePage(context);
                    },
                    child: const Text(
                      'Alimentos',
                      style: TextStyle(
                        fontSize: 15.0, // Tamanho do texto
                        fontWeight: FontWeight.bold, // Peso da fonte
                        color: Colors.black, // Cor do texto
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                      decoration: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: AppColors.blueUplace, // Cor do sublinhado
                          width: 2.0, // Largura do sublinhado
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          RoutesFunctions.gotoProductPage(context);
                        },
                        child: const Text(
                          'Produtos',
                          style: TextStyle(
                            fontSize: 15.0, // Tamanho do texto
                            fontWeight: FontWeight.bold, // Peso da fonte
                            color: AppColors.blueUplace, // Cor do texto
                          ),
                        ),
                      )),
                ),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    RoutesFunctions.gotoServicePage(context);
                  },
                  child: const Text(
                    'Serviços',
                    style: TextStyle(
                      fontSize: 15.0, // Tamanho do text // Peso da fonte
                      color: Colors.black, // Cor do texto
                    ),
                  ),
                ))
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: ImageCarousel(images: [
              //Carrossel dos Produtos
              'https://images.pexels.com/photos/632470/pexels-photo-632470.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              'https://images.pexels.com/photos/5088021/pexels-photo-5088021.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              'https://images.pexels.com/photos/963276/pexels-photo-963276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
            ]),
          ),
          const Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                ],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: const NavigationUplaceBar(),
    );
  }
}
