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
let overlay = ITGOverlayView(channelSlug: channelSlug, accountName: accountName, accountId: accountId, environment: .stage, delegate: self, language: language)
```

You'll need to implement the following delegate methods:
```
func getVideoTime() -> Double 
func overlayWillOpenActivity(height: CGFloat)
func overlayWillCloseActivity()
```
On the first method you'll need to provide the current video time (so that the overlay knows when to show content).
The other two methods will inform your app when an interaction is shown or closed (so you can adjust your interface if needed).

## Other options

For additional configuration, there are some variables you can set:
```
let overlay = ITGOverlayView(channelSlug: <your_channel_slug>,
                                  accountName: <your_account_name>,
                                  accountId: <your_account_id>,
                                  environment: .stage,
                                  delegate: self,
                                  language: "en",
                                  foreignId: <user_id>,
                                  userName: <user_name>,
                                  customUrl: <custom_overlay_url>)
```

Interface `language` can be configured on the load method.

`foreignId` and `userName` can be used to connect ITG content with your user's account.

`customUrl` can be used to set custom url for overlay.
