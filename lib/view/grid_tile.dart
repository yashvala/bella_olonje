import 'package:bella_olonje/model/listVegetable.dart';
import 'package:bella_olonje/reducer/action.dart' as action;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String price;
  final bool like;
  final int index;
  final dynamic imgUrl;
  double height, width;
  final String description;
  final Store<VegetableResponseList> store;

  CustomCard(
      {this.title,
      this.price,
      this.imgUrl,
      this.description,
      this.like,
      this.store,
      this.index});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Wrap(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Stack(
                // alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 2, top: index % 2 != 0 ? 90 : 44),

                    ///here we create space
                    ///for the circle avatar to get ut of the box
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Wrap(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(top: 75.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "₹" + price,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Text(
                                      description,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )),
                        ])),
                  ),

                  ///Image Avatar
                  Positioned(
                    right: 20,
                    top: index % 2 != 0 ? 40 : 10,
                    child: Container(
                        width: 108,
                        height: 108,
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
                        child: _imageView()),
                  ),
                  Positioned(
                    right: 0,
                    top: index % 2 != 0 ? 45 : 0,
                    child: InkWell(
                      onTap: () {
                        like
                            ? store.dispatch(new action.Action(
                                like: like, index: index, actions: "dislike"))
                            : store.dispatch(new action.Action(
                                like: like, index: index, actions: "like"));
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
                        child: like
                            ? Icon(Icons.favorite_sharp, color: Colors.red[700])
                            : Icon(Icons.favorite_outline_sharp,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _imageView() {
    if (imgUrl == null || imgUrl == "") {
      return Container(
        child: CircleAvatar(
          maxRadius: 26,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/place_holder.png'),
        ),
      );
    } else if (imgUrl is List) {
      return Container(
        child: CircleAvatar(
          maxRadius: 26,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imgUrl.first),
        ),
      );
    } else {
      return Container(
        child: CircleAvatar(
          maxRadius: 26,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imgUrl),
        ),
      );
    }
  }
}
