import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  final String aboutFilePath;

  /// Placeholder widget to be used when loading
  final Widget? _placeholder;

  AboutPage(this.aboutFilePath, this._placeholder);
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<String>? aboutTextRetrieveFuture;

  @override
  void initState() {
    super.initState();
    aboutTextRetrieveFuture = retrieveAboutText();
  }

  Future<String> retrieveAboutText() async {
    return await DefaultAssetBundle.of(context)
        .loadString(widget.aboutFilePath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: aboutTextRetrieveFuture,
        builder: (context, snapshot) {
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return widget._placeholder??Container(color: Colors.black,) ;
          }

          return Center(
            heightFactor: 0.2,
              child: AutoSizeText(
            snapshot.data as String,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.merge(TextStyle(color: Colors.white)),
          ));
        });
  }
}
