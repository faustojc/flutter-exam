import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam/model/person.dart';
import 'package:flutter_exam/presentation/components/person_info_card.dart';
import 'package:flutter_exam/presentation/components/person_info_row.dart';
import 'package:intl/intl.dart';

class PersonDetailsPage extends StatelessWidget {
  final Person person;

  const PersonDetailsPage(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  FastCachedImage(
                    url: person.image,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 500),
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                    loadingBuilder: (context, progress) {
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: progress.progressPercentage.value,
                          ),
                        ),
                      );
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Theme.of(context).primaryColor],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(person.fullName),
            ),
          ),
          // Person Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Information Card
                  PersonInfoCard(
                    title: 'Basic Information',
                    children: [
                      PersonInfoRow(Icons.person, 'Name', person.fullName),
                      PersonInfoRow(Icons.email, 'Email', person.email),
                      PersonInfoRow(Icons.phone, 'Phone', person.phone),
                      PersonInfoRow(
                        Icons.cake,
                        'Birthday',
                        DateFormat('MMMM d, y').format(person.birthday),
                      ),
                      PersonInfoRow(Icons.person_outline, 'Gender', person.gender),
                      InkWell(
                        onTap: () {},
                        child: PersonInfoRow(
                          Icons.language,
                          'Website',
                          person.website,
                          isLink: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Address Card
                  PersonInfoCard(
                    title: 'Address',
                    children: [
                      PersonInfoRow(
                        Icons.home,
                        'Street',
                        '${person.address.buildingNumber} ${person.address.streetName}',
                      ),
                      PersonInfoRow(Icons.location_city, 'City', person.address.city),
                      PersonInfoRow(Icons.location_on, 'Country', person.address.country),
                      PersonInfoRow(Icons.mail_outline, 'Zip Code', person.address.zipcode),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
