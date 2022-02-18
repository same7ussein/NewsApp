import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.g.dart';
import '../modules/search.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, index) {},
        builder: (context, index) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'News App',
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          navigateTo(context, const SearchScreen());
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          cubit.changeMode();
                        },
                        icon: const Icon(
                          Icons.brightness_4_outlined,
                          size: 30,
                        )),
                  ),
                ],
              ),
              body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: cubit.bottomItem,
              ),

              //language
              drawer: Drawer(
                backgroundColor: Color.fromRGBO(25, 40, 47, 0.5),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Change Your Country ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Card(
                        elevation: 5,
                        child: LanguagePickerDropdown(
                          initialValue: Languages.avestan,
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (language) {
                            NewsCubit.get(context).selectLanguage =
                                language.isoCode;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}

//language
Widget _buildDropdownItem(language) {
  return Row(
    children: <Widget>[
      const SizedBox(
        width: 8.0,
      ),
      Text(
        "${language.name} (${language.isoCode})",
        style: const TextStyle(color: Colors.black),
      ),
    ],
  );
}
