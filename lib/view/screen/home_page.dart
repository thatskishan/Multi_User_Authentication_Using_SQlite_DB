import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/helper/db_helper.dart';
import '../../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User loggedInUser;

  const HomeScreen({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<User> users = await DBHelper.dbHelper.fetchAllRecords();
    setState(() {
      _users = users;
    });
  }

  void _deleteUser(User user) async {
    int result = await DBHelper.dbHelper.deleteRecord(id: user.id);
    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      _fetchUsers();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete user'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _logout() {
    Navigator.of(context).pushReplacementNamed('/');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User Log out Successfully.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = widget.loggedInUser.role == 'Admin';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Users",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _logout();
                      },
                      icon: const Icon(Icons.login)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    User user = _users[index];
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          user.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: const Color(0xff3C37FF),
                          ),
                        ),
                        subtitle: Text(
                          user.role,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        trailing: isAdmin
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Delete User',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          content: Text(
                                            'Are you sure you want to delete this user?',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _deleteUser(user);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
