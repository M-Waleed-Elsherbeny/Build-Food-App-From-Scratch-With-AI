import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_success_model.dart';
import 'order_success_state.dart';

/// Cubit managing the state of the Order Success screen.
class OrderSuccessCubit extends Cubit<OrderSuccessState> {
  OrderSuccessCubit() : super(const OrderSuccessState());

  /// Loads the order success summary data.
  void loadOrderSuccessData() {
    emit(state.copyWith(status: OrderSuccessStatus.initial));
    
    // Simulate loading local/fake success details.
    final fakeSuccessData = OrderSuccessModel.fake();
    
    emit(state.copyWith(
      status: OrderSuccessStatus.successLoaded,
      orderSuccessData: fakeSuccessData,
    ));
  }
}
