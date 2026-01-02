___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "MACRO",
  "id": "city_normalizer",
  "version": 1,
  "securityGroups": [],
  "displayName": "City Normalizer",
  "description": "Normalizes city names for server-side tracking by removing spaces, punctuation, and numbers while preserving UTF-8 characters.",
  "containerContexts": [
    "SERVER"
  ],
  "categories": ["UTILITY"],
  "brand": {
    "id": "metryxstudio",
    "displayName": "Metryx Studio"
  }
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "rawCity",
    "displayName": "Raw City Name",
    "simpleValueType": true,
    "help": "The city name in its original form."
  }
]

___SANDBOXED_JS_FOR_SERVER___

var makeString = require('makeString');

/**
 * Normalizes city names for hashing: converts to lowercase, removes spaces, punctuation,
 * and numbers, but preserves UTF-8 special characters (accents, diacritics).
 * Returns undefined for missing/invalid cities to prevent sending empty values.
 * Compliant with Facebook, Google, TikTok normalization requirements.
 * 
 * Example: "New York" → "newyork", "São Paulo" → "saopaulo", "Čakovec" → "čakovec"
 * 
 * @param {Object} data - Input object containing the raw city name.
 * @returns {string|undefined} The normalized city string, or undefined if input is invalid.
 */
var normalizeCity = function(data) {
  var rawCity = data.rawCity;

  if (!rawCity) {
    return undefined;
  }

  var cityString = makeString(rawCity).trim().toLowerCase();
  
  if (cityString.length === 0) {
    return undefined;
  }
  
  var normalizedCity = '';
  var charsToRemove = ' \'"-.,;:!?()[]{}/@#$%^&*+=_|\\<>~`0123456789';
  
  for (var i = 0; i < cityString.length; i++) {
    var char = cityString.charAt(i);
    
    if (charsToRemove.indexOf(char) === -1) {
      normalizedCity = normalizedCity + char;
    }
  }
  
  if (normalizedCity.length === 0) {
    return undefined;
  }
  
  return normalizedCity;
};

return normalizeCity(data);


___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios:
- name: Basic normalization
  code: |-
    const mockData = {
      rawCity: 'Zagreb'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('zagreb');
- name: City with space
  code: |-
    const mockData = {
      rawCity: 'New York'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('newyork');
- name: City with hyphen
  code: |-
    const mockData = {
      rawCity: 'Grad-City'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('gradcity');
- name: UTF-8 Portuguese
  code: |-
    const mockData = {
      rawCity: 'São Paulo'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('saopaulo');
- name: Croatian city with č
  code: |-
    const mockData = {
      rawCity: 'Čakovec'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('čakovec');
- name: City with šžć
  code: |-
    const mockData = {
      rawCity: 'Šibenik'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('šibenik');
- name: French city
  code: |-
    const mockData = {
      rawCity: 'Montréal'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('montréal');
- name: German city
  code: |-
    const mockData = {
      rawCity: 'München'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('münchen');
- name: Uppercase and spaces
  code: |-
    const mockData = {
      rawCity: '  LOS ANGELES  '
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('losangeles');
- name: City with apostrophe
  code: |-
    const mockData = {
      rawCity: "L'Hospitalet"
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('lhospitalet');
- name: City with numbers
  code: |-
    const mockData = {
      rawCity: 'District 5'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('district');
- name: City with period
  code: |-
    const mockData = {
      rawCity: 'St. Petersburg'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('stpetersburg');
- name: Empty input returns undefined
  code: |-
    const mockData = {
      rawCity: ''
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Only spaces returns undefined
  code: |-
    const mockData = {
      rawCity: '   '
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Complex example
  code: |-
    const mockData = {
      rawCity: 'São João-da-Madeira'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('saojoaodamadeira');
- name: Undefined input returns undefined
  code: |-
    const mockData = {};
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Only numbers returns undefined
  code: |-
    const mockData = {
      rawCity: '12345'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
