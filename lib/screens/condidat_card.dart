import 'package:flutter/material.dart';

import '../models/condidats.dart';

class CondidatCard extends StatelessWidget {
  const CondidatCard({
    Key? key,
    required this.itemIndex,
    required this.condidat,
    required this.press,
  }) : super(key: key);

test 
  static const URLpic = 'https://smdev.tn/storage/condidat_pic/';

  final int itemIndex;
  final Condidat condidat;
  // ignore: prefer_typing_uninitialized_variables
  final dynamic press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8 / 2,
      ),
      height: 190.0,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ],
              ),
            ),
            Positioned(
              top: 45.0,
              left: 0.0,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 120.0,
                width: 130.0,
                child: Image.network(URLpic +
                    (condidat.photo == ''
                        ? 'unknown_profile.png'
                        : condidat.photo!)),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 136.0,
                // Because oure image is 200 width, then: width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        condidat.nom! + ' ' + condidat.prenom!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Tel : ${condidat.num_tel}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8 * 1.5, // 30 px padding
                          vertical: 8 / 5, // 5 px padding
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 216, 114, 114),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text('Examen : ${condidat.examen}'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
