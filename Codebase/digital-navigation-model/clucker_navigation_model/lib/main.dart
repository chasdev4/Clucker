import 'package:flutter/material.dart';

const eminencePurple = Color.fromARGB(255, 109, 64, 130);

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

class NavigationButton extends StatelessWidget {
  const NavigationButton(this.buttonColor, this.routeName, this.text,
      [this.isNewCluck = false]);

  final Color buttonColor;
  final String routeName;
  final String text;
  final bool isNewCluck;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        onPressed: () {
          if (isNewCluck == false) {
            Navigator.pop(context);
          }
          Navigator.pushNamed(context, routeName);
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar(this.buttonColor);

  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    const double gapWidth = 2;

    return Row(
      children: <Widget>[
        const SizedBox(width: gapWidth),
        NavigationButton(buttonColor, '/Home', 'Home'),
        const SizedBox(width: gapWidth),
        NavigationButton(buttonColor, '/Discover', 'Discover'),
        const SizedBox(width: gapWidth),
        NavigationButton(buttonColor, '/NewCluck', 'New\nCluck', true),
        const SizedBox(width: gapWidth),
        NavigationButton(buttonColor, '/Search', 'Search'),
        const SizedBox(width: gapWidth),
        NavigationButton(buttonColor, '/Notification', 'Notifi-\ncation'),
        const SizedBox(width: gapWidth),
      ],
    );
  }
}

class StandardButton extends StatelessWidget {
  const StandardButton(this.buttonColor, this.routeName, this.text,
      [this.shouldPopAll = false]);

  final Color buttonColor;
  final String routeName;
  final String text;
  final bool shouldPopAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 50),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
            ),
            onPressed: () {
              if (shouldPopAll == true) {
                while (Navigator.canPop(context)) {
                  Navigator.popUntil(context, (route) => false);
                }
              }
              Navigator.pushNamed(context, routeName);
            },
            child: Text(text),
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cluckerRed = Color.fromARGB(255, 255, 87, 87);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-In Screen'),
        backgroundColor: cluckerRed,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
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
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: cluckerRed, width: 3),
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
              const SizedBox(
                width: 20,
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
    const orangeRed = Color.fromARGB(255, 255, 69, 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up Screen'),
        backgroundColor: orangeRed,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          StandardButton(orangeRed, '/Home', 'Sign Up', true),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const viridian = Color.fromARGB(255, 64, 130, 109);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        backgroundColor: viridian,
      ),
      body: Column(
        children: const <Widget>[
          StandardButton(viridian, '/EditProfile', 'Edit Profile'),
          StandardButton(viridian, '/Settings', 'Settings'),
          StandardButton(viridian, '/Following', 'Following'),
          StandardButton(viridian, '/Followers', 'Followers'),
          StandardButton(viridian, '/SignIn', 'Log Out', true),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: NavigationBar(viridian),
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
        backgroundColor: eminencePurple,
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tomato = Color.fromARGB(255, 255, 99, 71);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
        backgroundColor: tomato,
      ),
      body: Column(
        children: const <Widget>[
          StandardButton(tomato, '/BlockedUsers', 'Blocked Users'),
          StandardButton(tomato, '/TermsOfUse', 'Terms Of Use'),
          StandardButton(tomato, '/PrivacyPolicy', 'Privacy Policy'),
          StandardButton(tomato, '/About', 'About'),
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
        backgroundColor: Colors.indigo.shade400,
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
        backgroundColor: eminencePurple,
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
        backgroundColor: eminencePurple,
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const royalBlue = Color.fromARGB(255, 65, 105, 225);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
        backgroundColor: royalBlue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          StandardButton(royalBlue, '/Profile', 'Profile'),
          NavigationBar(royalBlue),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const crimson = Color.fromARGB(255, 220, 20, 60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: crimson,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          StandardButton(crimson, '/Profile', 'Profile'),
          NavigationBar(crimson),
        ],
      ),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const corn = Color.fromARGB(255, 230, 184, 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Screen'),
        backgroundColor: corn,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          StandardButton(corn, '/Profile', 'Profile'),
          NavigationBar(corn),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const patriarch = Color.fromARGB(255, 128, 0, 128);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
        backgroundColor: patriarch,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          StandardButton(patriarch, '/Profile', 'Profile'),
          NavigationBar(patriarch),
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
        backgroundColor: const Color.fromARGB(255, 5, 144, 51),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
