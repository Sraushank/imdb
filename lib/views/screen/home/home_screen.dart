import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imdb/views/utils/colors/app_colors.dart';
import 'package:imdb/views/utils/widget/series_widget/series_item.dart';
import 'package:provider/provider.dart';
import '../../../controller/series_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SeriesProvider>(context, listen: false).fetchSeriesData();
    });

    _searchController.addListener(() {
      Provider.of<SeriesProvider>(context, listen: false)
          .setSearchQuery(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Scaffold(
      backgroundColor: CupertinoColors.opaqueSeparator,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
          style: TextStyle(
            color: AppColor.charcoalGray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: AppColor.charcoalGray),
                  hintText: 'Search for series...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: seriesProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : seriesProvider.seriesList.isEmpty
                  ? Center(
                child: Text(
                  'No series found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: seriesProvider.seriesList.length,
                itemBuilder: (context, index) {
                  final series = seriesProvider.seriesList[index];
                  return MovieCard(
                    title: series.title ?? 'No Title',
                    imageUrl: series.bigImage ??
                        '',
                    genres: series.genre ?? [],
                    rating: series.rating ?? 0.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
