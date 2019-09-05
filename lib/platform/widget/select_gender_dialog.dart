import 'package:flutter/material.dart';
class SelectGenderDialog extends StatefulWidget{

  Function onSelect;

  SelectGenderDialog(this.onSelect);

  @override
  State<StatefulWidget> createState() {
    return SelectGenderState(onSelect);
  }
}

class SelectGenderState extends State<SelectGenderDialog>{

  Function onSelect ;
  int gender = -1;

  SelectGenderState(this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 220,
          height: 140,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))
              )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RadioListTile<int>(
                      value: 0,
                      title: Text("男",style: TextStyle(fontSize: 14),),
                      groupValue: gender,
                      onChanged: (gender){
                        onSelect(gender);
                        setState(() {
                          this.gender = gender;
                          Navigator.of(context).pop();
                        });
                      }
                  ),
                  flex: 1,
                ),

                Expanded(
                  child: RadioListTile<int>(
                      value: 1,
                      title: Text("女",style: TextStyle(fontSize: 14),),
                      groupValue: gender,
                      onChanged: (gender){
                        onSelect(gender);
                        setState(() {
                          this.gender = gender;
                          Navigator.of(context).pop();
                        });
                      }
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}