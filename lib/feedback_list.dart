import 'package:flutter/material.dart';
import 'form_controller.dart';
import 'form.dart';
import 'package:condition/condition.dart';
import 'package:checkdigit/checkdigit.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Responses',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: FeedbackListPage(title: "My Buddies"));
  }
}

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>();

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          return VolunteerTile(
            photo: feedbackItems[index].photo,
            name: feedbackItems[index].name,
            age: feedbackItems[index].age,
            address: feedbackItems[index].address,
            email: feedbackItems[index].email,
            mobileNo: feedbackItems[index].mobileNo,
            aadhar: feedbackItems[index].aadhar,
          );
        },
      ),
    );
  }
}

class VolunteerTile extends StatelessWidget {
  final String photo, address, name, email, age, aadhar, mobileNo;

  VolunteerTile(
      {this.photo,
      this.address,
      this.name,
      this.email,
      this.age,
      this.aadhar,
      this.mobileNo});

  @override
  Widget build(BuildContext context) {
    bool isValid = verhoeff.validate(aadhar);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Color(0xFFffc0b4)),
      ),
      padding: EdgeInsets.all(12),
      child: Conditioned.boolean(
        isValid == true,
        trueBuilder: () => (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                        child: Image.network(photo))),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Age $age',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFffc0b4),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Address : $address',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Email Address : $email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Mobile Number : $mobileNo',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Aadhar card no. : $aadhar',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
        falseBuilder: () => Text(
          '$name \ncannot be a buddy as the Aadhar Card Number is not valid.',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
    );
  }
}
