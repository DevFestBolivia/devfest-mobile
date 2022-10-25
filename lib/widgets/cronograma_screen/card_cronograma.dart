import 'package:devfestbolivia/constans.dart';
import 'package:flutter/material.dart';

class CardCronograma extends StatelessWidget {
  const CardCronograma({Key? key, this.interval = false}) : super(key: key);
  final bool interval;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: kElevationToShadow[(interval) ? 0 : 1],
        color: (interval) ? const Color(0xffF1F1F1) : Colors.white,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            hour(),
            const VerticalDivider(
              color: Color.fromARGB(255, 185, 192, 197),
              thickness: 1,
            ),
            if (!interval) photo(),
            if (!interval) nameSpeaker(width, context),
            if (interval)
              SizedBox(
                  width: width * 0.625,
                  child: Text(
                    "Almuerzo",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ))
          ],
        ),
      ),
    );
  }

  SizedBox hour() {
    return SizedBox(
      width: 48,
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
            text: "10:00\n",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: primaryColor, fontSize: 18),
            children: [
              TextSpan(
                  text: 'AM',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ]),
      ),
    );
  }

  ClipOval photo() {
    return ClipOval(
      child: Image.network(
        "https://i0.wp.com/www.kahanihindi.com/wp-content/uploads/2021/06/Girls-profile-picture-8.jpg?resize=450%2C400&ssl=1",
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }

  Column nameSpeaker(double width, BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: width * 0.45,
            child: Text(
              "Las Actualizaciones de Google Asistant",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            )),
        SizedBox(
            width: width * 0.45,
            child: const Text(
              "Wilson Botosh",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xff80868B)),
            ))
      ],
    );
  }
}
