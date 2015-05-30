# SPBannerView
An interactive banner with gesture-based actions, written in Swift

![Screenshot](https://dl.pushbulletusercontent.com/SyAeySsAfTFr6T4kpDq8hLvEI9uoinly/IMG_2906.PNG)
![Screenshot](https://dl.pushbulletusercontent.com/s3Lyq2p46iGMNIzyXqvERHc1OH4hiFv2/IMG_2907.PNG)

#Installation
* Copy `SPBannerView.swift` and `CEMKit.swift` into your project.
* Copy the example project's podfile, or copy the relevant lines into your podfile (FontAwesomeKit is not required, but is reccomended)
* Run `pod install`

####CocoaPods is coming when the library is more mature

#How to use
SPBannerView is a UIScrollView subclass that adds an action on the left, right, or both that are triggered using gestures.

Actions are defined using swift completion handlers.

Here is a basic SPBannerView implementation (Using font awesome for icons):

```
var refreshIcon = FAKFontAwesome.refreshIconWithSize(20)
refreshIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
var randomIcon = FAKFontAwesome.randomIconWithSize(20)
randomIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        
self.banner = SPBannerView(parent: self.view, color: UIColor.amethystColor(), text: "Banner")
        
self.banner.addRightAction(refreshIcon.attributedString(), action: {()
in
    println("Right action triggered")
    self.banner.goToMainView()
})
        
self.banner.addLeftAction(randomIcon.attributedString(), action: {()
in
    println("Left action triggered")
    self.banner.goToMainView()
})
        
self.view.addSubview(self.banner)
```

When adding actions, the action label is an NSAttributedString. I reccomend using FontAwesomeKit to get the associated NSAttributedString for their icons. If you would like UIImage support for labels, let me know by opening an issue

##Notes
* This currently depends on CEMkit (not my code) for some convenience initializers related to UILabels. I will remove this dependency in future versions.
* Currently, the banner will always occupy CGRect(x: 0, y: 0, width: parent.bounds.width, height: 100). I will include functions to modify this behaviour in future versions
