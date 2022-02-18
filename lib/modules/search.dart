import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeMode();
                    },
                    icon: const Icon(
                      Icons.brightness_4_outlined,
                      size: 30,
                    )),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: NewsCubit.get(context).isDark
                    ? defaultFormField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        controller: searchController,
                        type: TextInputType.text,
                        onchange: (value) {
                          if (value.isEmpty) {
                            NewsCubit.get(context).search = [];
                          }
                          NewsCubit.get(context).getSearch(value);
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                      )
                    : defaultFormField(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        controller: searchController,
                        type: TextInputType.text,
                        onchange: (value) {
                          if (value.isEmpty) {
                            NewsCubit.get(context).search = [];
                          }
                          NewsCubit.get(context).getSearch(value);
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                      ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
