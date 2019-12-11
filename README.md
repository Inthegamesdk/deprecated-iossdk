# iossdk

This SDK allows you to easily integrate the In The Game engagement platform in a video player in your iOS app.
The repository includes an example app that shows how to use the framework.


## Instalation

To install, simply drag the **InTheGameSDK.framework** file into your project. 

Configure the framework as Embedded on your project target settings:

![](https://i.imgur.com/GsuJVIc.png)

And import the SDK in your code:

`import InTheGameSDK`


## Usage

To quickly show a full-screen controller of your interactive video channel:

```
let url = URL(string: "<your video url>")!
let controller = ITGPlayerViewController.instantiate(videoURL: url)
present(controller, animated: true, completion: nil)
```

To load the video channel in a view to fit your custom layout, load the `ITGPlayerView` instead, and then add it as a subview (with constraints as needed): 

```
let playerView = ITGPlayerView.instantiate(videoURL: exampleVideoURL)
```

There are two additional parameters for further configuration: `language` and `allowsFullScreen`.
You can check the example app for a pratical implementation.

## Notes

The framework contains both device and simulator modules, so keep in mind that to upload it to the app store, you'll need to add a script to remove the simulator modules for release.
