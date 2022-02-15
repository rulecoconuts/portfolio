import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/data/skill.dart';

class SkillsWidget extends StatefulWidget {
  final String skillsFilePath;
  final int columns;
  final int dividerPaddingPercentage;

  SkillsWidget(this.skillsFilePath, this.columns, {this.dividerPaddingPercentage: 2});

  @override
  State<StatefulWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  Future<List<Skill>>? retrieveSkillsFuture;

  @override
  void initState() {
    retrieveSkillsFuture = retrieveSkills(widget.skillsFilePath);
  }

  /// Retrieve the list of skills to be displayed
  Future<List<Skill>> retrieveSkills(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);

    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Skill> skillList = jsonList.map((skillJson) {
      return Skill.fromJson(skillJson as Map<String, dynamic>);
    }).toList();

    return skillList;
  }

  List<List<Skill>> _breakdownIntoSkillRows(List<Skill> skills) {
    List<List<Skill>> rows = [];
    List<Skill> currentRow = [];

    for (int i = 0; i < skills.length; i++) {
      currentRow.add(skills[i]);
      if ((i % widget.columns) == widget.columns - 1) {
        rows.add(currentRow);
        currentRow = [];
      }
    }

    if (currentRow.length != 0 && currentRow.length < widget.columns)
      rows.add(currentRow);
    return rows;
  }

  Widget _generateSkillWidgetsRow(List<Skill> row) {
    List<Widget> widgetsRow = [];
    int numPads = row.length - 1;
    int numWidgets = row.length + (widget.columns - row.length);
    int paddingPercentage = widget.dividerPaddingPercentage;
    int remainingPercentage = (100 - (numPads * paddingPercentage));

    int valuablePercentage = remainingPercentage ~/ numWidgets;

    for (int i = 0; i < numWidgets; i++) {
      // Add main widget
      if (i >= row.length) {
        widgetsRow.add(Expanded(flex: valuablePercentage, child: Container()));
      } else {
        widgetsRow.add(
            Expanded(flex: valuablePercentage, child: SkillWidget(row[i])));
      }

      // Add padding
      if (i != numWidgets - 1) {
        widgetsRow.add(Expanded(
          flex: paddingPercentage,
          child: Container(),
        ));
      }
    }

    return Row(
      children: widgetsRow,
    );
  }

  Widget _generateSkillWidgets(List<Skill> skills) {
    return Column(
      children: _breakdownIntoSkillRows(skills).map((row) {
        return Expanded(child: _generateSkillWidgetsRow(row));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveSkillsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          List<Skill> skills = snapshot.data as List<Skill>;

          Widget skillWidgets = _generateSkillWidgets(skills);

          return Center(
            child: skillWidgets,
          );
        });
  }
}

class SkillWidget extends StatelessWidget {
  final Skill skill;
  SkillWidget(this.skill);

  Widget _generateSkillSlider(Skill skill, BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.never,
            inactiveTrackColor: Theme.of(context).primaryColor,
            activeTrackColor: Theme.of(context).secondaryHeaderColor,
            thumbShape: SliderComponentShape.noThumb,
            overlayShape: SliderComponentShape.noOverlay),
        child: Slider(
          label: "hii",
          value: skill.proficiency,
          onChanged: (value) {},
          mouseCursor: SystemMouseCursors.basic,
        ));
  }

  Widget getSkillNameWidget(Skill skill, BuildContext context) {
    return FittedBox(
        fit: BoxFit.cover,
        child: Text(
          "${skill.name}",
          style: Theme.of(context)
              .textTheme
              .button
              ?.merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
        ));
  }

  Widget getSkillProficiencyWidget(Skill skill, BuildContext context) {
    return FittedBox(
        fit: BoxFit.cover,
        child: Text(
          "${skill.proficiency * 100}%",
          style: Theme.of(context)
              .textTheme
              .button
              ?.merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
        ));
  }

  Widget _generateSkillWidget(Skill skill, BuildContext context) {
    return Column(
      children: [
        _generateSkillSlider(skill, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [getSkillNameWidget(skill, context)],
            )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [getSkillProficiencyWidget(skill, context)],
            ))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _generateSkillWidget(skill, context);
  }
}
