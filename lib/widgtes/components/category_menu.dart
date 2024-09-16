import 'package:flutter/material.dart';
import 'package:uplace/widgtes/routes/routes.dart';
import 'package:uplace/widgtes/themes/colors.dart';

class CategoryMenu extends StatefulWidget {
  final Function(String) onSelectedCategory;

  const CategoryMenu({
    super.key,
    required this.onSelectedCategory,
  });

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  String selectedCategory = "Alimentos";
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: categoryMenuTextButton("Alimentos"),
        ),
        Expanded(
          child: categoryMenuTextButton("Produtos"),
        ),
        Expanded(
          child: categoryMenuTextButton("Serviços"),
        )
      ],
    );
  }

  TextButton categoryMenuTextButton(String category) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
        widget.onSelectedCategory(category);
        // RoutesFunctions.gotoHomePage(context);
      },
      child: selectedCategory == category
          ? DecoratedBox(
              decoration: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.blueUplace, // Cor do sublinhado
                  width: 2.0, // Largura do sublinhado
                ),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 15.0, // Tamanho do texto
                  fontWeight: FontWeight.bold, // Peso da fonte
                  color: AppColors.blueUplace, // Cor do texto
                ),
              ),
            )
          : Text(
              category,
              style: const TextStyle(
                fontSize: 15.0, // Tamanho do texto
                fontWeight: FontWeight.normal, // Peso da fonte
                color: Colors.black, // Cor do texto
              ),
            ),
    );
  }
}
