//
//  ViewController.swift
//  SPBannerView
//
//  Created by Connor MacBook on 2015-05-30.
//  Copyright (c) 2015 cohix. All rights reserved.
//

import UIKit
import FontAwesomeKit

class ViewController: UIViewController {

    var banner: SPBannerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

