import 'dart:convert';
import 'package:driving/models/condidats.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as Dio;
import '../dio.dart';
import 'condidat_card.dart';

class CondidatsScreen extends StatefulWidget {
  const CondidatsScreen({super.key});

  @override
  State<CondidatsScreen> createState() => _CondidatsScreenState();
}

class _CondidatsScreenState extends State<CondidatsScreen> {
  Future<List<Condidat>> getCondidats() async {
    Dio.Response response = await dio()
        .get('/allCondidats', options: Dio.Options(headers: {'auth': true}));

    List condidats = json.decode(response.toString());

    return condidats.map((condidat) => Condidat.fromJson(condidat)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste condidats'),
      ),
      body: Center(
        child: Center(
          child: Center(
              child: FutureBuilder<List<Condidat>>(
                  future: getCondidats(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) => CondidatCard(
                                itemIndex: index,
                                condidat: snapshot.data![index],
                                press: () {},
                              ));
                    } else if (snapshot.hasError) {
                      return Text('No posts found!');
                    }

                    return CircularProgressIndicator();
                  })),
        ),
      ),
    );
  }
}
