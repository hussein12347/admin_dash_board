import 'package:admin_dash_board/core/models/product_model.dart';

import 'cart_item_entity_model.dart';

class CarEntity{
  final List<CarItemEntity>CarItems;
  CarEntity({required this.CarItems});


  addCartItem(CarItemEntity carItemEntity){
    CarItems.add(carItemEntity);
  }
  isExist(ProductModel productModel){
    for(var product in CarItems ){
      if(product.product.productId==productModel.productId){
        return true;
      }
    }
    return false;

  }

  CarItemEntity getCarItem(ProductModel productModel){
    for(var product in CarItems ){
      if(product.product.productId==productModel.productId){
        return product;
      }
    }
    return CarItemEntity(product: productModel,count: 1);
  }

  double calculateTotalPrice(){
    double totalPrice =0;
    for(var product in CarItems ){
      totalPrice+=product.calculateTotalPrice();
    }
    return totalPrice;

  }

  void deleteCarItem(CarItemEntity carItemEntity) {
    CarItems.remove(carItemEntity);
  }
}