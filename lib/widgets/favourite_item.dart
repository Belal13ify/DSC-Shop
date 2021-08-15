import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/firebase_provider.dart';

class FavouriteItem extends StatelessWidget {
  final String id;
  final String title;
  final num price;
  final String image;
  final isFav;
  final VoidCallback deleteFavourite;

  FavouriteItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.isFav,
    required this.deleteFavourite,
  });

  @override
  Widget build(BuildContext context) {
    // var fb = Provider.of<FirebaseProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 7, right: 7),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 5,
              ),
              Image.network(
                image,
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: IconButton(
                    onPressed: deleteFavourite,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          // Colors.red,
                          isFav ? Colors.red : Colors.black,
                      size: 30,
                    )),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
