import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/utils/morpheus_color.dart';
import 'package:morpheus_common/widgets/did_selector.dart';
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
                converter: (Store<AppState> store) => DidsSelectorContext(
                  store.state.activeDid,
                  (newActiveDid) => store.dispatch(SetActiveDIDAction(newActiveDid))
                ),
                builder: (_,DidsSelectorContext selectorContext) => DidsDropdown(
                  widget.dids,
                  selectorContext.activeDid,
                  selectorContext.setActiveDid
                ),
              )
            ]
        )
    );
  }
}
