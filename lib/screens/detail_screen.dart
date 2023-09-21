import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? id;
  String? title;
  Future<Map<String, dynamic>>? detailFuture;
  Future<Map<String, dynamic>> getData(String? id) async {
    var response = await http
        .get(Uri.parse('https://api.codingthailand.com/api/course/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> chapters = json.decode(response.body);
      return chapters;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    id = Get.parameters['id'];
    title = Get.parameters['title'];
    detailFuture = getData(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: FutureBuilder<Map<String, dynamic>>(
          future: detailFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text('${snapshot.data?['data']?[index]['ch_title']}'),
                    subtitle: Text(
                        '${snapshot.data?['data']?[index]['ch_timetotal']}'),
                    trailing: Chip(
                      label:
                          Text('${snapshot.data?['data']?[index]['ch_view']}'),
                      padding: const EdgeInsets.all(2),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    onTap: () {},
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!['data']!.length,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
