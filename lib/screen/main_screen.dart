import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:recipe_proj/db/db_helper.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../animation/m_animation.dart';
import '../model/recipe_model.dart';
import 'detail_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _refreshData(DateTime.now());
    initializeDateFormatting();
  }

  List<Recipe> myData = [];
  int all = 0;
  List<Recipe> filteredRecipes = [];

  void deleteItem(int id) async {
    await DatabaseHelper.deleteItemInProgress(id);
    _refreshData(DateTime.now());
  }
  String formatYear(String? year) {
    year == '';
    if (year == '0' || year == '00' || year == '000' || year == '0000') {
      return DateTime.now().year.toString();
    } else if (year!.length == 4) {
      return year;
    } else if (year.length == 2) {
      int currentYear = DateTime.now().year;
      int prefix = currentYear ~/ 100;
      return '$prefix$year';
    } else if (year.length == 3 || year.length == 1) {
      int currentYear = DateTime.now().year;
      return currentYear.toString();
    } else {
      return DateTime.now().year.toString();
    }
  }

  Future<void> _refreshData(DateTime selectedDay) async {
    dynamic data = await DatabaseHelper.retrieveSelectedRecipes(selectedDay);
    setState(() {
      myData = data;
      myData.length = data.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Главная",
                  style: TextStyle(color: darkGreen, fontSize: 26.0),
                ),
                Calendar(
                  refreshDataCallback: _refreshData,
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.3),
                          height: (MediaQuery.of(context).size.height * 0.1),
                          child: NeumorphicButton(
                            padding:
                                const EdgeInsets.only(left: 6.0, top: 10.0),
                            onPressed: () {},
                            style: NeumorphicStyle(
                                depth: 5,
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.check_box_sharp,
                                        size: 14, color: darkGreen),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text("Всегo дел:",
                                        style: TextStyle(
                                            color: darkGreen, fontSize: 13))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('${myData.length}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: darkGreen,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.3),
                          height: (MediaQuery.of(context).size.height * 0.1),
                          child: NeumorphicButton(
                            padding:
                                const EdgeInsets.only(left: 6.0, top: 10.0),
                            onPressed: () {},
                            style: NeumorphicStyle(
                                depth: 5,
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Icon(Icons.downloading,
                                          size: 14, color: darkGreen),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text("В процессе:",
                                          style: TextStyle(
                                              color: darkGreen, fontSize: 13))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("5",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkGreen,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.3),
                          height: (MediaQuery.of(context).size.height * 0.1),
                          child: NeumorphicButton(
                            padding:
                                const EdgeInsets.only(left: 6.0, top: 10.0),
                            onPressed: () {},
                            style: NeumorphicStyle(
                                depth: 5,
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.done,
                                        size: 14, color: darkGreen),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text("Выполнено:",
                                        style: TextStyle(color: darkGreen))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("3",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkGreen,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                  future: DatabaseHelper.retrieveSelectedRecipes(DateTime(0)),
                  builder: (context, snapshot) {
                     if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.hasData) {
                     //final selectedDay = _selectedDay ?? DateTime(0);
                      //  filteredRecipes = snapshot.data!.where((recipe) {
                      //   final recipeDay = int.parse(recipe.day);
                      //   final recipeMonth = int.parse(recipe.month);
                      //   final recipeYear = int.parse(recipe.year);
                      //   return recipeYear == selectedDay.year &&
                      //       recipeMonth == selectedDay.month &&
                      //       recipeDay == selectedDay.day;
                      // }).toList();
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myData.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                deleteItem(myData[index].id);
                              });
                            },

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeDetail(
                                            recipe: myData[index]
                                          ),
                                    ));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: lCream,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child:
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: (index < myData.length && myData[index].image != null)
                                                  ? Image.memory(myData[index].image as Uint8List, fit: BoxFit.cover)
                                                  : Image.asset(
                                                "assets/images/Dish.jpg",
                                                fit: BoxFit.cover,
                                              ),),
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          SizedBox(
                                            height: 100,
                                            width: 200,
                                            child: Text(
                                              myData.length > index ? myData[index].title : '',
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 100,
                                            width: 60,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: const Alignment(1.0, 1.0),
                                                  child: Text(
                                                      myData.length > index ? "${myData[index].time} min" : '', style: const TextStyle(color: mOrange, fontSize: 14),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const Alignment(-11, 1),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      myData.length > index
                                                          ? myData[index].day.padLeft(2, '0') : DateTime.now().day.toString(),
                                                      style: const TextStyle(color: mOrange),
                                                    ),
                                                  ),
                                                ),
                                                const Align(
                                                  alignment: Alignment(-8.42, 1.06),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                        '.', style: TextStyle(
                                                      fontSize: 18, color: mOrange
                                                    ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const Alignment(-10.1, 1),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      myData.length > index
                                                          ? myData[index].month.padLeft(2, '0') : DateTime.now().month.toString(),
                                                      style: const TextStyle(color: mOrange),
                                                    ),
                                                  ),
                                                ),
                                                const Align(
                                                  alignment: Alignment(-7.76, 1.05),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      '.', style: TextStyle(
                                                        fontSize: 16, color: mOrange
                                                    ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const Alignment(-14, 1.0),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      myData.length > index ? formatYear(myData[index].year) : DateTime.now().year.toString(), style: const TextStyle(
                                                        color: mOrange
                                                    ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                          );
                        }, separatorBuilder: (context,index) => const SizedBox(height: 8.0,)
                      ,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
typedef RefreshDataCallback = Future<void> Function(DateTime selectedDay);

class Calendar extends StatefulWidget {
  final RefreshDataCallback refreshDataCallback;
  const Calendar({super.key, required this.refreshDataCallback});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  var firstDay = DateTime.utc(2010, 10, 16);
  var lastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;


  @override
  Widget build(BuildContext context) {
    // DateTime focusedDay = DateTime.now();
    // String headerText = DateFormat.MMMM().format(focusedDay);
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      locale: Localizations.localeOf(context).languageCode,
      calendarFormat: _calendarFormat,
      weekendDays: const [DateTime.sunday, 6],
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: '▼',
        CalendarFormat.week: '▲',
      },
      daysOfWeekHeight: 30.0,
      rowHeight: 36.0,
      onDaySelected: (selectedDay, focusedDay) async {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
         await widget.refreshDataCallback(selectedDay);
        }
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      headerStyle: HeaderStyle(
        titleTextFormatter: (DateTime date, dynamic time) => DateFormat.MMMM(time).format(date),
        formatButtonVisible: true,
        leftChevronIcon: const Icon(Icons.arrow_back_ios),
        rightChevronVisible: false,
        titleCentered: true,
        titleTextStyle:
        const TextStyle(fontSize: 18.0), ///////
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        formatButtonTextStyle:
            const TextStyle(color: Colors.white, fontSize: 16.0),
        formatButtonDecoration: BoxDecoration(
          color: aDarkGreen.withOpacity(0.6),
          borderRadius: const BorderRadius.all(
            Radius.circular(57.0),
          ),
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) =>
            DateFormat.E(locale).format(date)[0],
        weekendStyle: const TextStyle(color: Color(0x594F4F4F), fontSize: 18.0),
        weekdayStyle: const TextStyle(color: Color(0x594F4F4F), fontSize: 18.0),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        weekendTextStyle: const TextStyle(fontSize: 16),
        selectedTextStyle: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        isTodayHighlighted: true,
        todayDecoration: const BoxDecoration(
          color: mOrange,
          shape: BoxShape.circle
        ),
        selectedDecoration: BoxDecoration(
            border: Border.all(width: 1.0),
            color: darkGreen,
            shape: BoxShape.circle),
      ),
    );
  }
}
