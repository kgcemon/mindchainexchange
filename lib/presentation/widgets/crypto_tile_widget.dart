import 'package:flutter/material.dart';

class CryptoTile extends StatelessWidget {
  final String name;
  final String price;
  final String change;
  final Color color;
  final String volume;
  final String img;

  const CryptoTile({
    super.key,
    required this.name,
    required this.price,
    required this.change,
    required this.color,
    required this.volume,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Image.network(img),
              ),
              const SizedBox(width: 10),
              Text(
                "$name\n Vol $volume",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
              Text(
                change,
                style: TextStyle(
                    color: change.contains('-') ? Colors.red : Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}