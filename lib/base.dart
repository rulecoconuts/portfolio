import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/about.dart';
import 'package:portfolio/banner.dart';
import 'package:portfolio/data/contact.dart';
import 'package:portfolio/data/education.dart';
import 'package:portfolio/data/experience.dart';
import 'package:portfolio/skills.dart';

class BasePage extends StatefulWidget {
  final Contact _contact;

  BasePage(this._contact);

  _BagePageState createState() => _BagePageState();
}

class _BagePageState extends State<BasePage> {
  Map<String, Widget> pages = {
    "Home": Container(color: Colors.purple,),
  };
  String selectedPage = "Home";

  @override
  void initState(){
    super.initState();
    pages["Home"] = BannerPage("assets/banner.txt", placeholderWidget: _placeholderPage,);
    pages["Skills"] = SkillsWidget("assets/skills.json", 3);
    pages["Projects"] = _placeholderPage;
    pages["About"] = AboutPage("assets/about.txt", _placeholderPage);
  }

  Widget _wrapText(Text text) {
    return FittedBox(fit: BoxFit.cover, child: text);
  }

  Widget get _firstName {
    return _wrapText(
        Text(widget._contact.firstName, style: TextStyle(color: Colors.white)));
  }

  Widget get _lastName {
    return _wrapText(Text(
      widget._contact.lastName,
      style: TextStyle(color: Colors.amber),
    ));
  }

  Widget get _names {
    return Row(children: [
      Expanded(
          child:
              Padding(padding: EdgeInsets.only(right: 5), child: _firstName)),
      Expanded(child: _lastName)
    ]);
  }

  void _onPageNavClicked(String title) {
    setState(() {
      selectedPage = title;
    });
  }

  Widget _generateSelectedPageNavText(String title) {
    return ElevatedButton(
      onPressed: () => _onPageNavClicked(title),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.merge(TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }

  Widget _generatePageNavText(String title) {
    return ElevatedButton(
      onPressed: () => _onPageNavClicked(title),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent)),
    );
  }

  Widget _generatePageNav(String title) {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: title == selectedPage
          ? _generateSelectedPageNavText(title)
          : _generatePageNavText(title),
    );
  }

  Widget get _navBar {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: pages.keys.map(_generatePageNav).toList(),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Padding(padding: EdgeInsets.only(left: 10), child: _names),
        flex: 20,
      ),
      Expanded(flex: 25, child: Container()),
      Expanded(
        child: _navBar,
        flex: 55,
      )
    ]);
  }

  Widget get _phoneDisplay {
    return Container();
  }

  Widget get _placeholderPage {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
    );
  }

  Widget get _currentPage {
    return Column(children: [
      Expanded(
          child: FractionallySizedBox(
              widthFactor: 0.7, heightFactor: 0.7, child: pages[selectedPage])),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.black],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: Column(
          children: [
            Expanded(child: _topBar(context), flex: 1),
            Expanded(
              child: _currentPage,
              flex: 14,
            )
          ],
        ),
      ),
    ));
  }
}

