import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int page = 1;
  int pageSize = 5;
  int total = 0;
  List<dynamic> articles = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      articles.clear();
      page = 1;
    });
    await getData();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (page < ((total / pageSize).ceil())) {
      if (mounted) {
        setState(() {
          page = ++page;
        });
      }
      await getData();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
      _refreshController.resetNoData();
    }
  }

  Future<void> getData() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=jp&apiKey=ab0d4aca4cea481e8157d31c68eb2b23&page=$page&pageSize=$pageSize'));
    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      setState(() {
        total = resp['totalResults'];
        articles.addAll(resp['articles']);
      });
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title:
            total > 0 ? Text('$total News') : const CircularProgressIndicator(),
        backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        foregroundColor: Colors.white,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("loading..");
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed! Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("Data not found");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (context, index) => Card(
              child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: '${articles[index]['urlToImage']}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${articles[index]['title']}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${articles[index]['description']}'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Chip(
                        avatar: const Icon(Icons.stadium),
                        label: Text('${articles[index]['source']['name']}'),
                      )),
                  Expanded(
                      flex: 1,
                      child: Chip(
                        avatar: const Icon(Icons.publish_outlined),
                        label: Text(DateFormat.yMd().add_jm().format(
                            DateTime.parse(articles[index]['publishedAt']))),
                      ))
                ],
              ),
            ],
          )),
          // itemExtent: 100.0,
          itemCount: articles.length,
        ),
      ),
    );
  }
}
