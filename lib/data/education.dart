import 'package:portfolio/data/location.dart';

class Education{
  String major;
  String school;
  Location location;
  DateTime enrollment;
  DateTime graduation;

  List<String> accomplishments = [];

  Education(this.major, this.school, this.location, this.enrollment, this.graduation);
}