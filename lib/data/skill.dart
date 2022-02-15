import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill{
  String name;
  double proficiency;

  Skill(this.name, this.proficiency);

  factory Skill.fromJson(Map<String, dynamic> json)=>_$SkillFromJson(json);
}