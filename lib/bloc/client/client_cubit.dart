import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/storage.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(super.initialState);

  setTheme({required bool newTheme}) {
    var newState = ClientState(
      darkTheme: newTheme,
      language: state.language,
    );
    emit(newState);
    Storage().saveTheme(darkTheme: newTheme);
  }

  setLanguage({required String newLanguage}) {
    var newState = ClientState(
      darkTheme: state.darkTheme,
      language: newLanguage,
    );
    emit(newState);
    Storage().saveLanguage(language: newLanguage);
  }

  getLanguage() {
    return state.language;
  }

  getTheme() {
    return state.darkTheme;
  }
}
