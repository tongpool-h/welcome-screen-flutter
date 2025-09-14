import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> assetImageList = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    // add more paths...
  ];

  // If you're using network:
  // final List<String> networkImageList = [
  //   'https://example.com/img1.jpg',
  //   'https://example.com/img2.jpg',
  //   // add more URLs...
  // ];

  @override
  Widget build(BuildContext context) {
    final images = assetImageList;
    final random = Random();

    return Scaffold(
      appBar: AppBar(
        // Remove the default elevation shadow if you like
        elevation: 0,
        // Set backgroundColor to transparent so gradient shows through
        backgroundColor: Colors.transparent,
        // Fill the entire AppBar area with a gradient
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 213, 27, 250), // start color
                Color.fromARGB(255, 214, 121, 237), // end color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        leading: Icon(Icons.menu, size: 40, color: Colors.white),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black45,
                  size: 40,
                ),
                onPressed: () {
                  // Action for notifications button
                  print('Notifications button pressed');
                },
              ),
              Positioned(
                right: 8.0,
                top: 8.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12.0,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 246, 134, 248),
                    radius: 11.0,
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 213, 27, 250), // start color
                      Color.fromARGB(255, 214, 121, 237), // end color
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),

                      // User Avatar and Name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32.0,
                            backgroundColor: Colors.amber,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                'assets/images/user_avatar.jpg',
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 40.0),
                              Text(
                                'Tongpool Heeptaisong',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '@tongpool-h',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 45.0),
                          OutlinedButton(
                            onPressed: () {
                              print('Follow button pressed');
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white, // text color
                              side: BorderSide(color: Colors.amber),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //Followers
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 75.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '867',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Follow',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '59',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1.2K',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),

              // Images Section
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Photos',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),

                // GridView for displaying images
                // child: GridView.builder(
                //   itemCount: images.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2, // Number of columns
                //     crossAxisSpacing: 8.0, // Horizontal space between items
                //     mainAxisSpacing: 8.0, // Vertical space between items
                //     childAspectRatio: 1.0, // Width/height ratio of each item
                //   ),
                //   itemBuilder: (BuildContext context, int index) {
                //     return ClipRRect(
                //       borderRadius: BorderRadius.circular(8.0),
                //       child: Image.asset(images[index], fit: BoxFit.cover),
                //     );
                //   },
                //   shrinkWrap: true, // Add this if GridView is inside a Column
                //   physics:
                //       NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
                // ),

                // Using MasonryGridView for a staggered grid layout  
                child: MasonryGridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    final height = random.nextInt(150) + 100.0;

                    return Container(
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
