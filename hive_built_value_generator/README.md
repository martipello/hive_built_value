### Extension for [hive](https://github.com/leisim/hive) please go there for documentation.
This implementation supports primitives, lists and maps but also any Dart object you like as well as built value objects such as BuiltList and BuiltMap.
It still supports wire names (when you want it to take the name from the api but call it something different in your code) but the annotation name has changed. 
Your type adapter and built value methods will all live in the same .g file part 
```dart

part 'person.g.dart';

@HiveType(typeId: 0)
abstract class Person implements Built<Person, PersonBuilder> {

  factory Person([void Function(PersonBuilder) updates]) = _$Person;
  Person._();

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  BuiltMap<String, Pet>? get pets;

  @HiveField(3)
  @BuiltValueField(wireName: 'alternative_name')
  String? get aka;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Person.serializer, this);
  }

  static Person fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Person.serializer, json);
  }

  static Serializer<Person> get serializer => _$personSerializer;
}
```