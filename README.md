# MeLiChallenge

## Description
This is an iOS Challenge using Mercado Libre API. The idea is to develop a basic app focusing on Design Patterns, UI/UX and good practices.

This is a basic version of Mercado Libre App

| Search View  | Product List  | Product Detail  |
|:-:|:-:|:-:|
|![searchView](https://user-images.githubusercontent.com/18274146/114113436-35d2d480-98a4-11eb-85b1-5e4fd3ccc5ad.png)|![productList](https://user-images.githubusercontent.com/18274146/114114736-10939580-98a7-11eb-8df0-0f2387b83e33.png)|![productDetail](https://user-images.githubusercontent.com/18274146/114114745-18ebd080-98a7-11eb-9521-06c7df48e59d.png)|
|In SearchView user can select the Country and quickly search. App will remember last Country selected to facilitate future searchs.  | In the ProductList, users can look at the different items listed and they are also able to make a new search using the top SearchBar.  | In the detailView, users are able to scroll horizontally trough pictures and also more information about the specific item is displayed. |

## Design
For the project I used **MVVM** pattern.

You can also find design patterns like Repository to handle requests, Delegate pattern to facilitate communication between objects and Singleton to log errors.

*There are no Third Party Dependencies in this project, everything was built using native libraries*

## What's Missing
### Handling Errors from User POV
Errors are handled internally but are just transparent to the user, I believe App's not going to crash. Could have used **UIAlertController** to easily communicate errors to the user.
