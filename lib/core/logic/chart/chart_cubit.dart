// import 'package:bloc/bloc.dart';
//
// import 'package:meta/meta.dart';
//
// import '../../models/cart_item_entity_model.dart';
// import '../../models/chart_entity.dart';
// import '../../models/product_model.dart';
//
// part 'chart_state.dart';
//
// class ChartCubit extends Cubit<ChartState> {
//   ChartCubit() : super(ChartInitial());
//
//   CarEntity carEntity = CarEntity(CarItems: []);
//   void addProduct(ProductModel product){
//     bool isExist=carEntity.isExist(product);
//     var carItem=carEntity.getCarItem(product);
//
//     if(isExist){
//       carItem.increaseCount();
//     }else{
//       carEntity.addCartItem(carItem);
//     }
//     emit(ChartItemAdded());
//   }
//
//   void clearCarEntity(){
//     carEntity=CarEntity(CarItems: []);
//   }
//
//    deleteChartItem(CarItemEntity carItemEntity){
//     carEntity.deleteCarItem(carItemEntity);
//     emit(ChartItemRemoved());
//   }
// }
