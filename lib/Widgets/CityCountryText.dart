import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:geocoding/geocoding.dart';


class CityCountryText extends StatelessWidget {
  final List<Placemark> placemarks;

  CityCountryText({required this.placemarks});
  String abbreviateCountry(String country) {
    Map<String, String> countryAbbreviations = {
      'Afghanistan': 'AFG',
      'Albania': 'ALB',
      'Algeria': 'DZA',
      'Andorra': 'AND',
      'Angola': 'AGO',
      'Antigua and Barbuda': 'ATG',
      'Argentina': 'ARG',
      'Armenia': 'ARM',
      'Australia': 'AUS',
      'Austria': 'AUT',
      'Azerbaijan': 'AZE',
      'Bahamas': 'BHS',
      'Bahrain': 'BHR',
      'Bangladesh': 'BGD',
      'Barbados': 'BRB',
      'Belarus': 'BLR',
      'Belgium': 'BEL',
      'Belize': 'BLZ',
      'Benin': 'BEN',
      'Bhutan': 'BTN',
      'Bolivia': 'BOL',
      'Bosnia and Herzegovina': 'BIH',
      'Botswana': 'BWA',
      'Brazil': 'BRA',
      'Brunei': 'BRN',
      'Bulgaria': 'BGR',
      'Burkina Faso': 'BFA',
      'Burundi': 'BDI',
      'Cabo Verde': 'CPV',
      'Cambodia': 'KHM',
      'Cameroon': 'CMR',
      'Canada': 'CAN',
      'Central African Republic': 'CAF',
      'Chad': 'TCD',
      'Chile': 'CHL',
      'China': 'CHN',
      'Colombia': 'COL',
      'Comoros': 'COM',
      'Congo (Congo-Brazzaville)': 'COG',
      'Costa Rica': 'CRI',
      'Croatia': 'HRV',
      'Cuba': 'CUB',
      'Cyprus': 'CYP',
      'Czechia (Czech Republic)': 'CZE',
      'Denmark': 'DNK',
      'Djibouti': 'DJI',
      'Dominica': 'DMA',
      'Dominican Republic': 'DOM',
      'Ecuador': 'ECU',
      'Egypt': 'EGY',
      'El Salvador': 'SLV',
      'Equatorial Guinea': 'GNQ',
      'Eritrea': 'ERI',
      'Estonia': 'EST',
      'Eswatini (fmr. "Swaziland")': 'SWZ',
      'Ethiopia': 'ETH',
      'Fiji': 'FJI',
      'Finland': 'FIN',
      'France': 'FRA',
      'Gabon': 'GAB',
      'Gambia': 'GMB',
      'Georgia': 'GEO',
      'Germany': 'DEU',
      'Ghana': 'GHA',
      'Greece': 'GRC',
      'Grenada': 'GRD',
      'Guatemala': 'GTM',
      'Guinea': 'GIN',
      'Guinea-Bissau': 'GNB',
      'Guyana': 'GUY',
      'Haiti': 'HTI',
      'Holy See': 'VAT',
      'Honduras': 'HND',
      'Hungary': 'HUN',
      'Iceland': 'ISL',
      'India': 'IND',
      'Indonesia': 'IDN',
      'Iran': 'IRN',
      'Iraq': 'IRQ',
      'Ireland': 'IRL',
      'Israel': 'ISR',
      'Italy': 'ITA',
      'Ivory Coast': 'CIV',
      'Jamaica': 'JAM',
      'Japan': 'JPN',
      'Jordan': 'JOR',
      'Kazakhstan': 'KAZ',
      'Kenya': 'KEN',
      'Kiribati': 'KIR',
      'Kuwait': 'KWT',
      'Kyrgyzstan': 'KGZ',
      'Laos': 'LAO',
      'Latvia': 'LVA',
      'Lebanon': 'LBN',
      'Lesotho': 'LSO',
      'Liberia': 'LBR',
      'Libya': 'LBY',
      'Liechtenstein': 'LIE',
      'Lithuania': 'LTU',
      'Luxembourg': 'LUX',
      'Madagascar': 'MDG',
      'Malawi': 'MWI',
      'Malaysia': 'MYS',
      'Maldives': 'MDV',
      'Mali': 'MLI',
      'Malta': 'MLT',
      'Marshall Islands': 'MHL',
      'Mauritania': 'MRT',
      'Mauritius': 'MUS',
      'Mexico': 'MEX',
      'Micronesia': 'FSM',
      'Moldova': 'MDA',
      'Monaco': 'MCO',
      'Mongolia': 'MNG',
      'Montenegro': 'MNE',
      'Morocco': 'MAR',
      'Mozambique': 'MOZ',
      'Myanmar (formerly Burma)': 'MMR',
      'Namibia': 'NAM',
      'Nauru': 'NRU',
      'Nepal': 'NPL',
      'Netherlands': 'NLD',
      'New Zealand': 'NZL',
      'Nicaragua': 'NIC',
      'Niger': 'NER',
      'Nigeria': 'NGA',
      'North Korea': 'PRK',
      'North Macedonia (formerly Macedonia)': 'MKD',
      'Norway': 'NOR',
      'Oman': 'OMN',
      'Pakistan': 'PAK',
      'Palau': 'PLW',
      'Palestine State': 'PSE',
      'Panama': 'PAN',
      'Papua New Guinea': 'PNG',
      'Paraguay': 'PRY',
      'Peru': 'PER',
      'Philippines': 'PHL',
      'Poland': 'POL',
      'Portugal': 'PRT',
      'Qatar': 'QAT',
      'Romania': 'ROU',
      'Russia': 'RUS',
      'Rwanda': 'RWA',
      'Saint Kitts and Nevis': 'KNA',
      'Saint Lucia': 'LCA',
      'Saint Vincent and the Grenadines': 'VCT',
      'Samoa': 'WSM',
      'San Marino': 'SMR',
      'Saudi Arabia': 'SAU',
      'Senegal': 'SEN',
      'Serbia': 'SRB',
      'Seychelles': 'SYC',
      'Sierra Leone': 'SLE',
      'Singapore': 'SGP',
      'Slovakia': 'SVK',
      'Slovenia': 'SVN',
      'Solomon Islands': 'SLB',
      'Somalia': 'SOM',
      'South Africa': 'ZAF',
      'South Korea': 'KOR',
      'South Sudan': 'SSD',
      'Spain': 'ESP',
      'Sri Lanka': 'LKA',
      'Sudan': 'SDN',
      'Suriname': 'SUR',
      'Sweden': 'SWE',
      'Switzerland': 'CHE',
      'Syria': 'SYR',
      'Tajikistan': 'TJK',
      'Tanzania': 'TZA',
      'Thailand': 'THA',
      'Timor-Leste': 'TLS',
      'Togo': 'TGO',
      'Tonga': 'TON',
      'Trinidad and Tobago': 'TTO',
      'Tunisia': 'TUN',
      'Turkey': 'TUR',
      'Turkmenistan': 'TKM',
      'Tuvalu': 'TUV',
      'Uganda': 'UGA',
      'Ukraine': 'UKR',
      'United Arab Emirates': 'ARE',
      'United Kingdom': 'GBR',
      'United States of America': 'USA',
      'United States': 'US',
      'Uruguay': 'URY',
      'Uzbekistan': 'UZB',
      'Vanuatu': 'VUT',
      'Venezuela': 'VEN',
      'Vietnam': 'VNM',
      'Yemen': 'YEM',
      'Zambia': 'ZMB',
      'Zimbabwe': 'ZWE',
    };

    String abbreviation = countryAbbreviations[country] ?? country;
    return abbreviation;
  }


  @override
  Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String city = placemark.locality ?? 'Unknown';
      String country =abbreviateCountry( placemark.country!);

      return

        GreyTextRegular(title:   "$city: $country", weight: FontWeight.w600, size: width*0.032);

    } else {
      return Text("Could not determine city and country.");
    }
  }
}