import 'package:bella_olonje/model/listVegetable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:bella_olonje/reducer/action.dart' as action;
import 'package:redux/redux.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final bool like;
  final List<dynamic> imageList;
  final String imageString;
  final list;
  final Store<VegetableResponseList> store;

  DetailScreen({this.index, this.imageList, this.imageString, this.list,this.store,this.like});

  @override
  _DetailScreenState createState() => new _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController1 = new ScrollController();
  ScrollController _scrollController2 = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: StoreProvider< VegetableResponseList>(

            store: widget.store,
            child:SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 44, 30, 18),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/images/left_arrow.svg',
                            width: 26.0,
                            height: 26.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StoreConnector<VegetableResponseList, Store<VegetableResponseList>>(
                      converter: (store) => store,
                      builder: (context, store) {
                        return Stack(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    widget.imageString == "" || widget.imageList==null
                                        ? Container(
                                      height: 280,
                                      child: Image.asset('assets/images/place_holder.png',
                                          fit: BoxFit.fill,width: 1000),
                                    )
                                        : widget.imageList is List
                                        ? getCarouselView(widget.imageList as List<dynamic>)
                                        : Container(
                                        height: 280,
                                        color: Colors.redAccent,
                                        child: Image.network(widget.imageString,fit: BoxFit.fill,width: 1000)
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: (){
                                    store.state.vegetables[widget.index].like? store.dispatch(new action.Action(like:store.state.vegetables[widget.index].like,index: widget.index,actions: "dislike")) : store.dispatch(new action.Action(like:store.state.vegetables[widget.index].like,index: widget.index,actions: "like"));
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 5.0),
                                          ),
                                        ],
                                      ),
                                      child: store.state.vegetables[widget
                                          .index].like? Icon(Icons
                                          .favorite_sharp,color: Colors
                                          .red[700],
                                      ) :Icon
                                        (Icons.favorite_outline_sharp)),
                                ),
                              ),
                            ]);}),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 32, 40, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.list.title,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Text('₹' + widget.list.price,
                            style: TextStyle(
                                fontSize: 26,
                                color: Color(0xFFFA4A0C),
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vitamins',
                          style: buildTextStyleMedium(),
                        ),
                        _buildChips(),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Minerals',
                          style: buildTextStyleMedium(),
                        ),
                        Text(
                          widget.list.minerals,
                          style: buildTextStyleLightGrey(),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Description',
                          style: buildTextStyleMedium(),
                        ),
                        Text(
                          widget.list.description,
                          style: buildTextStyleLightGrey(),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: Text(
                            'Pros',
                            style: buildTextStyleMedium(),
                          ),
                        ),
                        _prosList(widget.list.pros),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Cons',
                          style: buildTextStyleMedium(),
                        ),
                        _consList(widget.list.cons),
                        SizedBox(
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildChips() {
    String optionString = widget.list.vitamins;
    List<String> listString = optionString.split(",").toList();
    List<Widget> chips = new List();
    for (int i = 0; i < listString.length; i++) {
      Widget chip = Row(
        children: [
          Chip(
            label: Text(listString[i],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFA4A0C),
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            backgroundColor: Color(0xFFEBEBEB),
          ),
          SizedBox(
            width: 10,
          )
        ],
      );
      chips.add(chip);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: chips,
    );
  }

  TextStyle buildTextStyleMedium() {
    return TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);
  }

  TextStyle buildTextStyleLightGrey() {
    return TextStyle(
        fontSize: 18,
        color: Colors.black38,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.02);
  }

  Widget getCarouselView(List<dynamic> newList) {
    return GFCarousel(
      height: 280,
      autoPlay: true,
      pagination: true,
      viewportFraction: 1.0,
      activeIndicator: Color(0xFFFA4A0C),
      passiveIndicator: Color(0xFFC4C4C4),
      aspectRatio: 2,
      items:newList.map((item) => Container(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left:8.0,bottom: 25),
              child: Image.network(item, fit: BoxFit.fill, width: 1000),
            )
        ),
      )).toList(),
      onPageChanged: (index) {
        setState(() {});
      },
    );
  }



  Widget _prosList(data) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _scrollController1,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _greenTile(data[index]);
          }),
    );
  }

  Widget _greenTile(String title) => Container(
    child: ListTile(
      title: Text(title,
          style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.02)),
      leading: SvgPicture.asset(
        'assets/images/right_arrow_green.svg',
        width: 26.0,
        height: 26.0,
      ),
    ),
  );

  ListView _consList(data) {
    return ListView.builder(
        padding: EdgeInsets.all(0.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController2,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _redTile(data[index]);
        });
  }

  ListTile _redTile(String title) => ListTile(
    title: Text(
      title,
      style: TextStyle(
          fontSize: 15,
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.02),
    ),
    leading: SvgPicture.asset(
      'assets/images/right_arrow_red.svg',
      width: 26.0,
      height: 26.0,
    ),
  );
}
