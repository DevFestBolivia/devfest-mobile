import 'package:devfestbolivia/models/sponsor.dart';

class SponsorsUtil {
  List<Sponsor> getSponsors() {
    return const <Sponsor>[
      Sponsor(
        name: 'Ucatec',
        localImagePath: 'assets/images/ucatec.png',
        description:
            'Somos la Universidad UCATEC, nos hemos consolidado en Cochabamba como “La Primera Universidad que Forma Emprendedores” a nivel nacional e internacional, brindando una formación académica de calidad, basada en un Modelo Pedagógico Emprendedor, con metodologías activas que buscan el desarrollo de competencias personales y profesionales en sus estudiantes, con el objetivo de generar y gestionar propuestas creativas, productivas, técnicas y sociales que contribuyan al desarrollo sostenible del país.',
        webUrl: 'https://ucatec.edu.bo',
      ),
      Sponsor(
        name: 'tuGerente',
        localImagePath: 'assets/images/tugerente.png',
        description:
            'tuGerente es la herramienta #1 en la gestión de inventario online. Supervisa tu inventario en tiempo real de la manera más simple, donde sea y donde quieras.',
        webUrl:
            'https://www.tugerente.com/?fbclid=IwAR0T02XM74ADPzqPwPGTkGR8VkHi8LgdMiFNtu8pTFO4XavSBm8ZtQxsSbo',
      ),
      Sponsor(
        name: 'Digital Harbor',
        localImagePath: 'assets/images/digitalharbor.png',
        description:
            'Digital Harbor nació en 1997 en Estados Unidos como una compañía de aplicaciones compuestas; luego se expandió a India y Bolivia y formó un equipo de trabajo integrado por los tres países.\nActualmente Estados Unidos e India son los dos principales exportadores de software a nivel mundial.\nEn 2003 se abre la filial en Bolivia, una elección que se debió al nivel profesional de los ingenieros y desarrolladores de software del país y el potencial que ofrece la gran cantidad y calidad de universidades bolivianas que forman profesionales en el área de tecnología. Bolivia es parte de Digital Harbor gracias a la reputación que se creó.',
        webUrl: 'https://www.digitalharborbolivia.com',
      ),
      Sponsor(
        name: 'Clicket',
        localImagePath: 'assets/images/clicket.png',
        description:
            'Clicket es una solución integral para la gestión de eventos, donde tanto compradores como vendedores cumplen sus objetivos de una manera simple y confiable.',
        webUrl: 'https://clicket.bo',
      ),
    ];
  }
}
