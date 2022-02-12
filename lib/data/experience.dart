import 'package:portfolio/data/location.dart';

class Experience{
  String title;
  String workPlace;
  Location location;
  DateTime start;
  DateTime end;

  List<String> roles = [];

  Experience(this.title, this.workPlace, this.location, this.start, this.end);
}