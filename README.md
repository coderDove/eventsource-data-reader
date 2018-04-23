
# eventsource-data-reader
Simple iOS client for reading data from specified EventSource stream.

This application was developed using **XCode 9.3** and **Swift 4.1**. 
Earlier **XCode 9.x** can be used but as new **Codable** protocol was used from **Swift 4** it will not be able to build project with **XCode** with version earlier than **9.0** 

Application is using EventSource stream with API, data model and access point that were described at  this [link](https://github.com/netronixgroup/ios-dev/blob/master/TestTask.md).

Application is using a [third-party dependency](https://github.com/neilco/EventSource) for subscribing for EventSource stream. It is being managing by CocoaPods, so it is necessary to have CocoaPods install on your Mac. If you haven't CocoaPods installed in your system just follow simple steps on official [cocoapods.org](https://cocoapods.org/) website.

As soon as you have installed Cocoapods and pulled the source code you need to follow next steps to be able to correctly build and run this project:

 1. In Terminal navigate into root folder of pulled project (***.xcodeproj** file located in that folder).
 2. Execute `pod install` in Terminal.
 3. As soon as process will be finished - a new workspace should appear in root project directory - for now you should use this ***.xcworkspace** file to open project.
 4. If any issues appeared during `pod install` execution - try to visit [troubleshooting section](https://guides.cocoapods.org/using/troubleshooting.html) on cocoapods.org. The most common solution - try to execute `pod update` and after that `pod install` again.

The application can be built to all devices and simulators (both iPhone and iPad) which are running iOS 11.3

Application is also able to be able and tested using `xcode-build` command line tool, so in case of necessity to push this application project building to some CI/CD tool - it will not be a problem. 
