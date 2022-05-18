import 'package:flutter/material.dart';
import 'package:forum_republique/pages/widgets/navigation_drawer_widget.dart';
import '../l10n/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.home_page),
          actions: <Widget>[
            Padding(padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language) {

                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) =>
                      DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (context) =>
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
        ),
      );
}