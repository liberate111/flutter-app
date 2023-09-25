import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int page = 1;
  int pageSize = 5;
  Future<Map<String, dynamic>>? newsFuture;

  Future<Map<String, dynamic>> getData() async {
    var response =
        await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=jp&apiKey=ab0d4aca4cea481e8157d31c68eb2b23&page=$page&pageSize=$pageSize'));
    if (response.statusCode == 200) {
      Map<String, dynamic> news = json.decode(response.body);
      return news;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    newsFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MenuDrawer(),
        appBar: AppBar(
          title: const Text('news'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: newsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 160,
                            minHeight: 80,
                            maxWidth: 80,
                            minWidth: 80),
                        child: Image.network(
                          '${snapshot.data?['articles']?[index]['urlToImage']}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text('${snapshot.data?['articles']?[index]['title']}'),
                      subtitle:
                          Text('${snapshot.data?['articles']?[index]['description']}'),
                      trailing: Chip(
                        label:
                            Text('${snapshot.data?['articles']?[index]['source']['name']}'),
                        padding: const EdgeInsets.all(2),
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                      onTap: () {
                        // Get.toNamed(Uri.parse('detail?id=${snapshot.data?['data']?[index]['id']}&title=${snapshot.data?['data']?[index]['title']}').toString());
                      },
                    );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!['articles']!.length,
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