import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/customer_add_bloc.dart';
import 'package:woocommerce_app/helper/hex_color.dart';

class CustomerAddPage extends StatefulWidget {
  @override
  _CustomerAddPageState createState() => _CustomerAddPageState();
}

class _CustomerAddPageState extends State<CustomerAddPage> {
  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autoValidate = false;

  Map customerBasicInformation = new Map();

  Map customerAddressInformation = new Map();

  var bloc;

  @override
  void initState() {
    super.initState();
    bloc = CustomerAddBloc();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('New Customer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 36,
            ),
            onPressed: () {
              _validateInputs();
            },
          )
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(0.0),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return new Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: <Widget>[
          headerDivWidget('Basic Information'),
          new Container(
              padding: EdgeInsets.all(20.0),
              child: customerBasicInformationUI()),
          headerDivWidget('Address Information'),
          Container(
              padding: EdgeInsets.all(20.0),
              child: customerAddressInformationUI()),
        ]));
  }

  Widget headerDivWidget(String heaterText) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      //height: 40,
      padding: EdgeInsets.all(15),
      child: Text(
        heaterText,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
        color: HexColor("#FFF8F8"),
      ),
    );
  }

// Here is our Form UI
  Widget customerBasicInformationUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Firstname'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            if (val != null)
              customerBasicInformation['firstName'] = val;
            else
              customerBasicInformation['firstName'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Lastname'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerBasicInformation['lastName'] = val;
            else
              customerBasicInformation['lastName'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Username'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerBasicInformation['userName'] = val;
            else
              customerBasicInformation['userName'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            if (val != null) {
              customerBasicInformation['email'] = val;
              customerAddressInformation['email'] = val;
            }
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget customerAddressInformationUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Firstname'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['first_name'] = val;
            else
              customerAddressInformation['first_name'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Lastname'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['last_name'] = val;
            else
              customerAddressInformation['last_name'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType.phone,
          onSaved: (String val) {
            if (val != null)
              customerBasicInformation['phone'] = val;
            else
              customerBasicInformation['phone'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Company'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['Company'] = val;
            else
              customerAddressInformation['Company'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Address Line'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['address_1'] = val;
            else
              customerAddressInformation['address_1'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'City'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['city'] = val;
            else
              customerAddressInformation['city'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'State'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['state'] = val;
            else
              customerAddressInformation['state'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Postcode'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['postcode'] = val;
            else
              customerAddressInformation['postcode'] = '';
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Country'),
          keyboardType: TextInputType.text,
          onSaved: (String val) {
            if (val != null)
              customerAddressInformation['country'] = val;
            else
              customerAddressInformation['country'] = '';
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  String validateName(String value) {
    if (value.length < 1)
      return 'Field can not be empty';
    else if (value.length < 3)
      return 'Enter a valid value';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      //If all data are correct then save data to out variables
      _formKey.currentState.save();

      // After save data to variable a http request to create a new customer
      bloc.createCustomer(customerBasicInformation, customerAddressInformation,
          _scaffoldKey, context);
    } else {
      //If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
