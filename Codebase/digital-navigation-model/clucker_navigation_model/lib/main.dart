import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Routes Practice',
        initialRoute: '/SignIn',

        routes: {
          '/SignIn': (context) => const SignInScreen(),
          '/SignUp': (context) => const SignUpScreen(),
          '/Home': (context) => const HomeScreen(),
          '/Search': (context) => const SearchScreen(),
          '/Discover': (context) => const DiscoverScreen(),
          '/Notification': (context) => const NotificationScreen(),
          '/NewCluck': (context) => const NewCluckScreen(),
          '/UserMenu': (context) => const UserMenuScreen(),
          '/Profile': (context) => const ProfileScreen(),
          //'/EditProfile': (context) => const EditProfileScreen(),
          //'/Settings': (context) => const SettingsScreen(),
          //'/Followers': (context) => const FollowersScreen(),
          //'/Following': (context) => const FollowingScreen(),
          //'/BlockedUsers': (context) => const BlockedUsersScreen(),
          //'/TermsOfUse': (context) => const TermsOfUseScreen(),
          //'/PrivacyPolicy': (context) => const PrivacyPolicyScreen(),
          //'/About': (context) => const AboutScreen(),

        }
    ),
  );
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-In Screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('Sign In'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/SignUp');
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up Screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserMenuScreen extends StatelessWidget {
  const UserMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Menu'),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Column(
        children: <Widget> [
          Row(
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: <Widget> [
          Row(),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/UserMenu');
                  },
                  child: const Text('User Menu'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('H'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Discover');
                  },
                  child: const Text('D'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/NewCluck');
                  },
                  child: const Text('NC'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Search');
                  },
                  child: const Text('S'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Notification');
                  },
                  child: const Text('N'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('H'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Discover');
                  },
                  child: const Text('D'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/NewCluck');
                  },
                  child: const Text('NC'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Search');
                  },
                  child: const Text('S'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Notification');
                  },
                  child: const Text('N'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Screen'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/UserMenu');
                  },
                  child: const Text('User Menu'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('H'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Discover');
                  },
                  child: const Text('D'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/NewCluck');
                  },
                  child: const Text('NC'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Search');
                  },
                  child: const Text('S'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Notification');
                  },
                  child: const Text('N'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/UserMenu');
                  },
                  child: const Text('User Menu'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('H'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Discover');
                  },
                  child: const Text('D'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/NewCluck');
                  },
                  child: const Text('NC'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Search');
                  },
                  child: const Text('S'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Notification');
                  },
                  child: const Text('N'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewCluckScreen extends StatelessWidget {
  const NewCluckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Cluck Screen'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('H'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Discover');
                  },
                  child: const Text('D'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/NewCluck');
                  },
                  child: const Text('NC'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Search');
                  },
                  child: const Text('S'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Notification');
                  },
                  child: const Text('N'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}