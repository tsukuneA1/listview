import 'package:flutter/material.dart';

/// Flutter code sample for [Autocomplete].
///

List<Skill> skillList = [
  Skill(name: "ムーンフォース", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフォー", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフォ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),
  Skill(name: "ムーンフ", power: 95, type: "フェアリー", anotherName: "むーんふぉーす", classification: "特殊"),

];

void main() => runApp(const AutocompleteExampleApp());

class AutocompleteExampleApp extends StatefulWidget {
  const AutocompleteExampleApp({super.key});

  static String _displaySkillStringForOption(Skill option) => option.name;

  @override
  State<AutocompleteExampleApp> createState() => _AutocompleteExampleAppState();
}

class _AutocompleteExampleAppState extends State<AutocompleteExampleApp> {
  final TextEditingController _textSkillEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Basic'),
        ),
        body: Center(

          child: CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Type below to autocomplete the following possible results: ${AutocompleteBasicExample._kOptions}.'),
                    const AutocompleteBasicExample(),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child:Autocomplete<Skill>(
                        initialValue: TextEditingValue(text: skillList.first.name),
                        displayStringForOption: AutocompleteExampleApp._displaySkillStringForOption,
                        optionsBuilder: (TextEditingValue textEditingValue) { // 3.
                          if (textEditingValue.text == '') {
                            return skillList;
                          }
                          return skillList.where((Skill option) {// 4.
                            return option.name.toString().contains(textEditingValue.text) | option.anotherName.toString().contains(textEditingValue.text);
                          });
                        },
                        onSelected: (Skill skill) { // 5.
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white30,
                              ),
                              labelText: '攻撃技',
                              floatingLabelStyle: const TextStyle(fontSize: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.purple,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          );
                        },
                        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Skill> onSelected, skillList){
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 420,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 240,
                                    height: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                          color: const Color(0xffc7c7ff)
                                      ),
                                      color: const Color(0xFFe6e6fa),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: skillList.length,
                                      itemBuilder: (BuildContext context, int index){
                                        final Skill skills = skillList.elementAt(index);
                                        return GestureDetector(
                                          onTap: (){
                                            _textSkillEditingController.text = skills.name;
                                            onSelected(skills);
                                          },
                                          child: SkillWidget(skills: skills),
                                        );
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  static const List<String> _kOptions = <String>[];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

class Skill {
  Skill({
    required this.name,
    required this.power,
    required this.type,
    required this.anotherName,
    required this.classification
  });
  String name;
  String anotherName;
  int power;
  String type;
  String classification;
}

class SkillWidget extends StatelessWidget {
  const SkillWidget({
    super.key,
    required this.skills,
  });

  final Skill skills;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(skills.name),
        subtitle: Text('${skills.type} ${skills.power} ${skills.classification}'),
      ),
    );
  }
}