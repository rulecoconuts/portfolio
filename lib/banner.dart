import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget {
  final String assetFilePath;
  final Widget? placeholderWidget;
  BannerPage(this.assetFilePath, {this.placeholderWidget});

  @override
  State<StatefulWidget> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  Future<String>? bannerTextRetrievalFuture;

  @override
  void initState() {
    super.initState();
    bannerTextRetrievalFuture = Future(() async{
       return (await DefaultAssetBundle.of(context).loadString(widget.assetFilePath)).toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: bannerTextRetrievalFuture,
        builder: (ctxt, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return widget.placeholderWidget ?? Container();
          }
          return Center(
              heightFactor: 0.2,
              child: AutoSizeText(
                snapshot.data as String,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ));
        });
  }
}
