import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam/model/person.dart';

class PersonList extends StatelessWidget {
  final List<Person> persons;

  const PersonList(this.persons, {super.key});

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    itemCount: persons.length,
    shrinkWrap: true,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (context, index) {
      final person = persons[index];

      return ListTile(
        leading: CircleAvatar(
          child: FastCachedImage(
            url: person.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.person);
            },
            loadingBuilder: (context, progress) {
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                value: progress.progressPercentage.value,
              );
            },
          ),
        ),
        title: Text(person.fullName),
        subtitle: Text(person.email, style: TextStyle(fontSize: 12)),
        tileColor: Theme.of(context).colorScheme.secondaryFixedDim,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      );
    },
  );
}
