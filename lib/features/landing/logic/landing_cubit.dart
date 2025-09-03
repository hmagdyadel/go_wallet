import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../expenses/presentation/expenses_view.dart';
import '../../home/presentation/home_view.dart';
import '../../profile/presentation/profile_view.dart';
import 'landing_states.dart';

class LandingCubit extends Cubit<LandingStates> {
  LandingCubit() : super(const LandingStates.initial()) {
    screens = [const ProfileView(), const HomeView(), const ExpensesView()];
  }

  int currentIndex = 1;

  void changeIndex(int index) {
    emit(LandingStates.loading());
    currentIndex = index;
    emit(LandingStates.loaded());
  }

  List<Widget> screens = [];
}
