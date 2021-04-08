# MeLiChallenge

## Description
This is an iOS Challenge using Mercado Libre API. The idea is to develop a basic app focusing on Design Patterns, UI/UX and good practices.

This is a basic version of Mercado Libre App

* Search View
* Products List
* Product Detail

## Design
For the project I used **MVVM** pattern.

You can also find design patterns like Repository to reduce the coupling of the project and Delegate pattern to facilitate communication between objects.

*There are no Third Party Dependencies in this project, everything was built using native libraries*

## What's Missing
### Logs
I handled request and parsing errors, but I didn't actually added a Logger to those cases. I though of using native **Logger** class to keep track of those errors.

### Handling Errors from User POV
Errors are handled internally but are just transparent to the user, I believe App's not going to crash. Could have used **UIAlertController** to easily communicate errors to the user.
