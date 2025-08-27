import 'package:flutter/material.dart';

class TProductItemList extends StatelessWidget {
  final String? name, price, qty, total, imageUrl, currency;

  const TProductItemList({
    super.key,
    this.name,
    this.price,
    this.qty,
    this.total,
    this.imageUrl,
    this.currency
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(imageUrl ?? '', width: 60, height: 60, fit: BoxFit.cover),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name ?? 'Unknown',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // RIGHT SIDE
          Flexible(
            child: Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                Text('LKR ${price ?? '0'}'),
                Text('$qty'),
                Text('LKR ${total ?? '0'}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
