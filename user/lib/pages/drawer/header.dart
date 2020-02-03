import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/utils/morpheus_color.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:redux/redux.dart';

class Header extends StatefulWidget{
  final List<String> dids;

  const Header(this.dids, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    List<Widget> header = [
      Expanded(child: const Text('Your Profile',style: TextStyle(color: Colors.white,fontSize: 24)))
    ];

    if(widget.dids == null) {
      header.add(SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ));
    }

    return DrawerHeader(
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        margin: EdgeInsets.zero,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(children: header),
              StoreConnector(
                converter: (Store<AppState> store) => _DropDownStoreContext(
                  store.state.activeDid,
                  (newActiveDid) => store.dispatch(SetActiveDIDAction(newActiveDid))
                ),
                builder: (_,_DropDownStoreContext storeContext) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildDidsDropdown(storeContext)
                ),
              )
            ]
        )
    );
  }

  List<Widget> _buildDidsDropdown(_DropDownStoreContext storeContext) {
    if(widget.dids != null) {
      return [Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        margin: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: DropdownButton<String>(
          value: storeContext.activeDid,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black),
          style: TextStyle(color: Colors.black),
          underline: Container(height: 0),
          onChanged: (String newValue) {
            setState(()  => storeContext.setActiveDid(newValue));
          },
          items: widget.dids.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      )];
    }

    return [];
  }
}

class _DropDownStoreContext {
  String activeDid;
  void Function(String newActiveDid) dispatch;

  _DropDownStoreContext(this.activeDid, this.dispatch);

  void setActiveDid(String newActiveDid) {
    activeDid = newActiveDid;
    dispatch(newActiveDid);
  }
}