# Crypto Lab

Crypto-Lab ist eine crossfunktionale Applikation, die es dem User ermöglicht, eine Übersicht über
alle Kryptowährungen gebündelt an einem Ort zu haben.

## Projekt Beschreibung

Die App zeigt dir alle Kryptowährungen an und zu jeder Kryptowährung kann man den Kurssehen. Um
immer auf dem Laufenden zu bleiben kann man direkt in der App relevante Nachrichten anschauen. Dazu
kann man, um einen besseren Überblick zu bekommen, seine Lieblings Kryptowährung auswählen und sie
gesondert auf einem Blick anschauen. Features

- Kryptowährung Übersicht
- Krypto-Nachrichten
- Favoritenliste
- Kryptowährungs-Preiskurse
- Login
- Unitests
- CRUD: create, read, update und delete Kryptowährungen mit Firebase

## Wie man die App installiert

...

## Code-Aufbau

Requierements:

- jedes Betriebssystem (z.B.: Windows, Linux oder MacOS)
- IDE mit Flutter SDK (empfohlen: 2.8.1, Android Studio)

## Tools:

- Flutter
- Firebase
- CoinGecko API
- NewsAPI

## Struktur:

- Im „lib“ Ordner finden wir zuerst die Main datei. Allgemein haben wir das Projekt mit dem MVC
  Pattern aufgebaut. Im Controller sind unsere Service, wie z.B.: die Authentifikation mit Firebase.
  Im Model sind unsere Logischen Daten wie z.B.: Crypto, die alle Informationen, wie Name,
  beinhaltet. Und im View Ordner sind unsere UI Elemente und die Einzelnen Screens. Jeder Screen ist
  aufgeteilt in screen und screen_body.
- Widgets und Farben modularisiert und an einer Stelle definiert; dadurch eine gute Grundlage für
  eine mögliche Weiterentwicklung geschaffen (z.B. CustomPopup, CustomSnackbar, CustomColors).
- Alle Controller-Klassen sind als Singleton realisiert.