import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'camera_screen_event.dart';
part 'camera_screen_state.dart';

class CameraScreenBloc extends Bloc<CameraScreenEvent, CameraScreenState> {
  CameraScreenBloc() : super(CameraScreenInitial()) {
    on<CameraScreenEvent>((event, emit) {
      //
    });
  }
}
