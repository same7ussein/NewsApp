import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/cubit/states.dart';
import '../../modules/business.dart';
import '../../modules/health.dart';
import '../../modules/science.dart';
import '../../modules/sports.dart';
import '../../modules/technology.dart';
import '../network/local/cache.dart';
import '../network/remot/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  dynamic selectLanguage = 'en';
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.phone_android_outlined),
      label: ('Tecnology'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.health_and_safety),
      label: ('Health'),
    ),
  ];
  List<Widget> screen = const [
    BesinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    TechnologyScreen(),
    HealthScreen(),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getSports();
    }
    if (index == 3) {
      getTecnology();
    }
    if (index == 4) {
      getHealth();
    }
    emit(NewsBottomNavStates());
  }

  //business

  List<dynamic> business = [];
  void getBusiness() {
    emit(GetBusinessLoading());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'category': 'business',
      'language': selectLanguage,
      'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
    }).then((value) {
      business = value.data['articles'];
      emit(GetBusinessSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessError(error.toString()));
    });
  }

  //Science

  List<dynamic> science = [];
  void getScience() {
    emit(GetScienceLoading());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'category': 'Science',
        'language': selectLanguage,
        'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
      }).then((value) {
        science = value.data['articles'];
        emit(GetScienceSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceError(error.toString()));
      });
    } else {
      emit(GetScienceSuccess());
    }
  }

//sports

  List<dynamic> sports = [];
  void getSports() {
    emit(GetSportsLoading());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'category': 'Sports',
        'language': selectLanguage,
        'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
      }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsError(error.toString()));
      });
    } else {
      emit(GetSportsSuccess());
    }
  }

//Technology

  List<dynamic> technology = [];
  void getTecnology() {
    emit(GetTechnologyLoading());
    if (technology.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'category': 'Technology',
        'language': selectLanguage,
        'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
      }).then((value) {
        technology = value.data['articles'];
        emit(GetTechnologySuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetTechnologyError(error.toString()));
      });
    } else {
      emit(GetTechnologySuccess());
    }
  }

  //Health
  List<dynamic> health = [];
  void getHealth() {
    emit(GetHealthLoading());
    if (health.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'category': 'Health',
        'language': selectLanguage,
        'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
      }).then((value) {
        health = value.data['articles'];
        emit(GetHealthSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetHealthError(error.toString()));
      });
    } else {
      emit(GetHealthSuccess());
    }
  }

//Search

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(GetSearchLoading());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '13d8b392069b4ef3b8b0ea9470200228',
    }).then((value) {
      search = value.data['articles'];
      emit(GetSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchError(error.toString()));
    });
  }

//dark mode

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(ChangeModeStates());
      });
    }
  }
}
