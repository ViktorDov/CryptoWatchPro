import 'package:flutter/material.dart';
import 'dart:math';

class CustomButton extends StatefulWidget {
  final Color mainColor,
      secondColor; //we put final for the main color and second color
  final IconData iconData;
  final VoidCallback onTap; //we put the final for icondata

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState createState() =>
      // ignore: no_logic_in_create_state
      _CustomButtonState(mainColor, secondColor,
          iconData, onTap); //in here we put all of it inside the ()

  const CustomButton(this.mainColor, this.secondColor,
      this.iconData, {super.key, required this.onTap}); // we put it again with this.
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false; //so we can know if our button is pressed or not
  Color mainColor, secondColor; //we input the mainColor and Second Color
  IconData iconData; //we put the icon data
  final VoidCallback onTap; 
  _CustomButtonState(this.mainColor, this.secondColor,
      this.iconData, this.onTap); // we put it again with this.

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      //using transform.rotate so the rectangle shape rotate to rhombus
      angle: pi /
          4, //import dart:math first then the pi is for 3.14..., we divide by 4 to rotate it
      child: GestureDetector(
        onTap: onTap,
        //when we click they take the deatils but we dont use the react
        onTapDown: (details) {
          setState(() {
            isPressed = !isPressed;
          });
        },
        onTapUp: (details) {
          //if we let go our finger from the button
          setState(() {
            isPressed = !isPressed;
          });
        },
        onTapCancel: () {
          //its when we didnt remove our finger but we move out of the button
          setState(() {
            isPressed = !isPressed;
          });
        },
        child: Material(
          borderRadius: BorderRadius.circular(15), //making it have shadow
          elevation: (isPressed)
              ? 5
              : 10, //if pressed the elevation is 5, but if its not pressed elevation 10
          shadowColor: (isPressed)
              ? secondColor
              : mainColor, //if pressed use shadowcolor second, if not use maincolor for shadow
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                8), //to cut all the 4circle outside the widget, making it only shows the inside button
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: 50, //the sized box width
                  height: 50, //the height of the sized box
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        4), //making the sized box have border radius circular 15
                    color: (isPressed)
                        ? Colors.blueAccent
                        : mainColor, //if is pressed use second color, if not use main color
                    child: Transform.rotate(
                      //this is so we can rotate back to the normal angle for the icons so it doesnt follow the box
                      angle: -pi /
                          4, //this is so we can rotate back to the normal angle for the icons
                      child: Icon(
                        iconData,
                        size: 35,
                        color: Colors.white, //the color of the button
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
