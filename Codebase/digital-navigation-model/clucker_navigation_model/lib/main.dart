import 'package:flutter/material.dart';

const cluckerRed = Color.fromARGB(255, 255, 87, 87);

void main() {
  runApp(
    MaterialApp(title: 'Routes Practice', initialRoute: '/SignIn', routes: {
      '/SignIn': (context) => const SignInScreen(),
      '/SignUp': (context) => const SignUpScreen(),
      '/Home': (context) => const HomeScreen(),
      '/Search': (context) => const SearchScreen(),
      '/Discover': (context) => const DiscoverScreen(),
      '/Notification': (context) => const NotificationScreen(),
      '/NewCluck': (context) => const NewCluckScreen(),
      '/Profile': (context) => const ProfileScreen(),
      '/EditProfile': (context) => const EditProfileScreen(),
      '/Settings': (context) => const SettingsScreen(),
      '/Followers': (context) => const FollowersScreen(),
      '/Following': (context) => const FollowingScreen(),
      '/BlockedUsers': (context) => const BlockedUsersScreen(),
      '/TermsOfUse': (context) => const TermsOfUseScreen(),
      '/PrivacyPolicy': (context) => const PrivacyPolicyScreen(),
      '/About': (context) => const AboutScreen(),
    }),
  );
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Home');
            },
            child: const Text('Home'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Discover');
            },
            child: const Text('Disc-\nover'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/NewCluck');
            },
            child: const Text('New\nCluck'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Search');
            },
            child: const Text('Search'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Notification');
            },
            child: const Text('Notifi-\ncation'),
          ),
        ),
      ],
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          'Sign-In Screen',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          //textAlign: TextAlign.justify,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Divider(
            color: cluckerRed,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: cluckerRed,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text('Sign In'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(
                        color: cluckerRed,
                        width: 3
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/SignUp');
                  },
                  child: const Text(
                      'Sign Up',
                    style: TextStyle(
                      color: cluckerRed,
                    ),
                  ),
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
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    while (Navigator.canPop(context)) {
                      Navigator.popUntil(context, (route) => false);
                    }
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
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/EditProfile');
                  },
                  child: const Text('Edit Profile'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Settings');
                  },
                  child: const Text('Settings'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Following');
                  },
                  child: const Text('Following'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Followers');
                  },
                  child: const Text('Followers'),
                ),
              ),
            ],
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: NavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Screen'),
        backgroundColor: Colors.indigo.shade400,
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
        backgroundColor: Colors.deepOrange.shade400,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/BlockedUsers');
                  },
                  child: const Text('Blocked Users'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/TermsOfUse');
                  },
                  child: const Text('Terms Of Use'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/PrivacyPolicy');
                  },
                  child: const Text('Privacy Policy'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/About');
                  },
                  child: const Text('About'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users Screen'),
        backgroundColor: Colors.indigo.shade400,
      ),
    );
  }
}

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use Screen'),
        backgroundColor: Colors.indigo.shade400,
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy Screen'),
        backgroundColor: Colors.indigo.shade400,
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Screen'),
        backgroundColor: Colors.deepOrange.shade400,
      ),
    );
  }
}

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers Screen'),
        backgroundColor: Colors.indigo.shade400,
      ),
    );
  }
}

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following Screen'),
        backgroundColor: Colors.indigo.shade400,
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
          const NavigationBar(),
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
          const NavigationBar(),
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
          const NavigationBar(),
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
          const NavigationBar(),
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
      ),
    );
  }
}
