import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/themes/colors.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class CustomRate extends StatefulWidget {
  final String title, descriptions, text;
  final String? hintText;

  const CustomRate({Key? key, required this.title, required this.descriptions, required this.text,this.hintText}) : super(key: key);

  @override
  _CustomRateState createState() => _CustomRateState();
}

class _CustomRateState extends State<CustomRate> {
  final TextEditingController _noteController = TextEditingController();
  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius, right: Constants.padding,bottom: Constants.padding-10
          ),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              const SizedBox(height: 15,),
              Text(widget.descriptions,style: const TextStyle(fontSize: 13,color: Colors.blueGrey),textAlign: TextAlign.center,),
              const SizedBox(height: 22,),
              SmoothStarRating(
                  allowHalfRating: true,
                  onRatingChanged: (v) {
                    rating = v;
                    setState(() {});
                  },
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: subColor,
                  borderColor: subColor,
                  spacing:0.0,defaultIconData: Icons.star_border,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextField(
                      controller: _noteController,
                      minLines: 5,
                      maxLines: 15,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black
                      ),
                      // onSubmitted: (text) => _bloc.add(SetRateGuest(billId: widget.billId, note: text)),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(
                          fontSize: 12,color: Colors.grey
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: mainColor
                          ),
                          child: Center(child: Text(widget.text,style: const TextStyle(fontSize: 15,color: Colors.white),)))),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: mainColor
                ),
                child: const Icon(MdiIcons.emoticon,color: Colors.white,size: 50,)),
          ),
        ),
      ],
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}