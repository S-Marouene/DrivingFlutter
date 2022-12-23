// ignore_for_file: unused_field

import 'dart:async';
import 'package:driving/models/condidats.dart';
import 'package:driving/screens/details_condidat/details_condidat.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as Dio;
import '../constants.dart';
import '../data/allcondidats.dart';
import '../widgets/search_widget.dart';
import 'condidat_card.dart';

class CondidatsScreen extends StatefulWidget {
  const CondidatsScreen({super.key});

  @override
  State<CondidatsScreen> createState() => _CondidatsScreenState();
}

class _CondidatsScreenState extends State<CondidatsScreen> {
  String query = '';
  List<Condidat> condidats = [];
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final condidats = await CondidatsApi.getCondidats(query);
    setState(() => this.condidats = condidats);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            title: Text('Liste condidats'),
          ),
          body: Column(children: [
            const SizedBox(height: kDefaultPadding / 2),
            Expanded(
                child: Stack(children: [
              Container(
                margin: const EdgeInsets.only(top: 70.0),
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildSearch(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: ListView.builder(
                    itemCount: condidats.length,
                    itemBuilder: (context, index) => CondidatCard(
                          itemIndex: index,
                          condidat: condidats[index],
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  condidat: condidats[index],
                                ),
                              ),
                            );
                          },
                        )),
              ),
            ]))
          ]),
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nom ou prenom',
        //onChanged: (value) => {},
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final condidats = await CondidatsApi.getCondidats(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.condidats = condidats;
        });
      });

  /*  Widget buildBook(Condidat condidat) => ListTile(
        leading: Image.network(
          condidat.urlImage,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(book.title),
        subtitle: Text(book.author),
      ); */

}
