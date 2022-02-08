# In The Game iOS SDK

This SDK allows you to easily integrate the In The Game engagement platform in a video player in your iOS app.
The repository includes an example app that shows how to use the framework.


## Installation

To install, simply drag the **Inthegamemobile.xcframework** file into your project. 

Configure the framework as Embedded on your project target settings:

![](https://i.imgur.com/lE5U8Xm.png)

And import the SDK in your code:

`import Inthegamemobile`


## Usage

You can run the included project for a pratical implementation example.

To integrate it, you create a view for the ITG interactive Overlay and position it over your video player as you see fit.
You can create it as:
```
let overlay = ITGOverlayView(channelID: <your_channel_id>, broadcasterName: <your_account>, environment: .devDefault, delegate: self)
```
You'll need to implement the following delegate methods:
```
func didTapVideoArea() 
func getVideoTime() -> Double 
```
