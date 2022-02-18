import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'bloc/milkiyat_Bloc.dart';
import 'model/milkiyat_Model.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    getMilkiyatBloc.fetchAllList();
  }
  @override
  Widget build(BuildContext context) {
    List slider_images = [];
    List manual_slider = [];
    int _current = 0;
    List topPicks =[];
    return Scaffold(backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: getMilkiyatBloc.allList,
          builder: (context, AsyncSnapshot<MilkiyatModel>snapshot) {
            if(snapshot.hasData) {
              slider_images = snapshot.data!.backgroundImages[0].getSliderImages;
              manual_slider =snapshot.data!.getManualSlider;
              topPicks = snapshot.data!.getTopPicks;
              print(topPicks);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 280,color: Colors.black,
                      child: Stack(
                        children: <Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 2.0,
                              initialPage: 1,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 100),),
                            items: slider_images.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image(width: MediaQuery.of(context).size.width,image: NetworkImage(i['image']),fit: BoxFit.fill,);
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            top: 30.0,
                            left: 0.0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print("your menu action here");

                              },
                            ),
                          ),
                          Positioned(
                              top: 40.0,
                              left: 230.0,
                              right: 10,
                              child: Row(
                                children: const [
                                  Icon(Icons.location_pin,color: Colors.white,size: 15,),
                                  Text("1st Main Road",style: TextStyle(color: Colors.white,fontWeight:  FontWeight.bold),),
                                  Icon(Icons.keyboard_arrow_down,color: Colors.white,)
                                ],
                              )
                          ),
                          Positioned(
                            top: 80.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90.0),
                                    color: Colors.white),
                                child: Row(
                                  children:  [
                                    const Expanded(flex: 3,
                                      child: TextField(
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20.0,),
                                          hintText: "Locality ,Commercial, Flat",hintStyle: TextStyle(color: Colors.black26),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25) ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container(decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25) ),
                                        color: Colors.orange),height: 50,child: Center(child: const Text("Search",style: TextStyle(color: Colors.white),))))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 180.0,
                              left: 0.0,
                              right: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 45,right: 45),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:45,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Colors.orange),
                                        child: TextButton(
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 13,right: 13,top: 4,bottom: 4),
                                              child: Text(
                                                "Find Property",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ))),
                                    Container(
                                        height:45,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Colors.orange),
                                        child: TextButton(
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 13,right: 13,top: 4,bottom: 4),
                                              child: Text("Post a Property",
                                                  style: TextStyle(color: Colors.white)),
                                            ))),
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Column(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          reverse: false,
                          autoPlay: false,
                          onPageChanged: (index, ih) {
                            setState(() {
                              _current = index;
                              print("${_current}");
                            });
                          },
                        ),
                        items: manual_slider.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  i['image'],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: manual_slider.map(
                              (image) {
                            int index = manual_slider.indexOf(image);
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color:_current == index ? Colors.grey : Colors.white)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    margin: const EdgeInsets.symmetric(vertical: 0.50, horizontal: 0.50),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color:  Colors.orange),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(), // this was the part the I had to add
                      ),
                    ]),
                    const SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("Top Picks",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: const [
                              Text("SEE ALL",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),),
                              Icon(Icons.arrow_right_outlined,color: Colors.orange,),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width,height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: topPicks.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var indiaRupFormat = NumberFormat.compactSimpleCurrency(locale: 'en_IN');
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                              width: 150.0,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                      height: 100,
                                      width: 150,
                                      child: Image.network(
                                        topPicks[index]['thumbnail'],
                                        fit: BoxFit.fill,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(indiaRupFormat.format(topPicks[index]['price'])),
                                            const Icon(Icons.favorite_border)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(topPicks[index]['title'],style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 10,),
                                  SizedBox(height: 20,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: topPicks[index]['attributes'].length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Container(
                                              decoration:  BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(10) ),
                                                  color: Colors.grey[300]),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    Text(topPicks[index]['attributes'][i]['value'],style: const TextStyle(fontSize: 12),),
                                                    topPicks[index]['attributes'][i]['unit'] == null
                                                        ? const Text("")
                                                        : Text(" "+topPicks[index]['attributes'][i]['unit'],style: const TextStyle(fontSize: 12),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                child: Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.blueGrey,
                    period: const Duration(seconds: 1),
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            color: Colors.black26,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 200,
                            color: Colors.black26,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 190,
                            color: Colors.black26,
                          ),


                        ],
                      ),
                    )),
              );
            }
          }
      ),



      bottomNavigationBar:  SizedBox(height: 50,
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedItemColor: Colors.orange,
          selectedFontSize: 11.0,
          unselectedFontSize: 11.0,
          iconSize: 25.0,
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.home,)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.outbox,)),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.favorite,)),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.notifications_sharp,)),
              label: 'Notifications',
            ),
          ],
        ),
      ),
    );
  }
}
