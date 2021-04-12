# In The Game iOS SDK

This SDK allows you to easily integrate the In The Game engagement platform in a video player in your iOS app.
The repository includes an example app that shows how to use the framework.


## Installation

To install, simply drag the **InTheGameSDK.framework** file into your project. 

Configure the framework as Embedded on your project target settings:

![](https://i.imgur.com/GsuJVIc.png)

And import the SDK in your code:

`import InTheGameSDK`


## Usage

To quickly show a full-screen controller of your interactive video channel:

```
let url = URL(string: "<your video url>")!
let controller = ITGPlayerViewController.instantiate(videoURL: url, broadcasterName: "<your_itg_broadcaster_name>")
present(controller, animated: true, completion: nil)
```

To load the video channel in a view to fit your custom layout, load the `ITGPlayerView` instead, and then add it as a subview (with constraints as needed): 

```
let playerView = ITGPlayerView.instantiate(videoURL: url, broadcasterName: "<your_itg_broadcaster_name>")
```

There are two additional parameters for further configuration: `language` and `allowsFullScreen`.
You can run the included project for a pratical implementation example.

## Overlay mode

The overlay option allows for maximum flexibility - you create a view for the ITG interactive Overlay and position it over your video player as you see fit.
You can create it as:
```
let overlay = ITGOverlayView(videoURL: videoURL.absoluteString, broadcasterName: <your_itg_broadcaster_name>")
```
Since you are using your own video player, you will need to send playback updates manually to the overlay:
```
overlay.videoPlaying()
overlay.videoPaused()
overlay.videoStopped()
overlay.updateVideoTime(seconds: 60)
```

The overlay content will be sized to take the available space while fitting a specified video aspect. The default is the standard 16:9. For other video formats, you can set the aspect ratio as:
```
overlay.setAspectRatio(4/3)
```

The overlay will only assume touch events when they are over its content. Touches on the empty area will be passed to the next view, useful for video controls.

The delegate methods allow you to detect when an activity is opened or closed:
```
overlay.delegate = self
```
```
func didOpenActivity()
func didCloseActivity()
```

You can check the `OverlayExampleViewController` in the example app for an integration sample.
