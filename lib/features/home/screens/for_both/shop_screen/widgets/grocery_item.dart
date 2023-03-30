import 'package:flutter/material.dart';

import '../../../../../../core/mq.dart';
import '../../../../../../models/product_model.dart';
import '../../../../../../theme/pallet.dart';
import '../../product_details_screen/details_screen.dart';

class GroceryItem extends StatelessWidget {
  final MGrocery item;
  const GroceryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  void onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ItemDetailsSreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: MQuery.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.kBorderColor, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item.hashCode,
                  child: Image.network(
                    item.url,
                    height: constraints.maxHeight * 0.4,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "  ${item.name.length > 20 ? item.name.substring(0, 23) : item.name}...",
                  style: Pallete.kTitleStyle,
                  // overflow: TextOverflow.ellipsis,
                ),
       
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price}',
                      style: Pallete.kTitleStyle
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Pallete.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
