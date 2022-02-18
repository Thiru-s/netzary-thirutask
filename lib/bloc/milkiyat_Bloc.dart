
import 'package:netzary/model/milkiyat_Model.dart';
import 'package:netzary/network_provider/network_provider.dart';
import 'package:rxdart/rxdart.dart';
class MilkiyatBloc{
  final networkProvider =  NetworkProvider();
  final _contoller = PublishSubject<MilkiyatModel>();
  Stream<MilkiyatModel> get allList => _contoller.stream;
  fetchAllList() async{
    MilkiyatModel milkiyatmodel = await networkProvider.fetchList();
    _contoller.sink.add(milkiyatmodel);
  }
  dispose(){
    _contoller.close();
  }
}
final getMilkiyatBloc = MilkiyatBloc();