import 'package:admin_dash_board/core/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CarItemEntity extends Equatable {
  final ProductModel product;
  int count;

  CarItemEntity({required this.product, this.count = 0});

num calculateTotalPrice(){
  return count * double.parse(product.price);
}



  increaseCount(){
  count++;
}
  decreaseCount(){
  if(count>1){
    count--;
  }
}

  @override
  // TODO: implement props
  List<Object?> get props => [product];

}
