class MilkiyatModel{
  List<_AutoCarosel_Images> _background_image= [];
  List _manualslider= [];
  List _topPicks= [];
  MilkiyatModel.fromJson(Map<String, dynamic> parsedJson){
    print(parsedJson);
    List<_AutoCarosel_Images> temp = [];
    List tempItems = [];
    List tempTopPicks = [];

    if(parsedJson["background_images"] != null){
      _AutoCarosel_Images background_image = _AutoCarosel_Images(parsedJson["background_images"]);
      temp.add(background_image);
      _background_image = temp;
    }

    if(parsedJson["data"][0]['items'] != null){
      tempItems = parsedJson["data"][0]['items']  ;
    }
    _manualslider = tempItems;


    if(parsedJson["data"][1]['items'] != null){
      tempTopPicks = parsedJson["data"][1]['items']  ;
    }
    _topPicks = tempTopPicks;

  }
  List <_AutoCarosel_Images> get backgroundImages => _background_image;
  List get getManualSlider => _manualslider;
  List get getTopPicks => _topPicks;
}

class _AutoCarosel_Images{

  late List _image;

  _AutoCarosel_Images(result){
    _image = result;
  }
  List get getSliderImages => _image;
}
