
import Foundation
import UIKit
import FlatUIKit

class SPBannerView: UIScrollView, UIScrollViewDelegate
{
    var mainView: UIView!
    var mainLabel: UILabel!
    
    var leftAction: Bool = false
    var rightAction: Bool = false
    
    var leftView: UIView!
    var rightView: UIView!
    
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var leftSpinner: UIActivityIndicatorView!
    var rightSpinner: UIActivityIndicatorView!
    
    var leftActionHandler: () -> Void
    var rightActionHandler: () -> Void
    
    override init(frame: CGRect)
    {
        self.leftActionHandler = {() in }
        self.rightActionHandler = {() in }
        
        super.init(frame: frame)
        self.contentSize = CGSize(width: frame.width+200, height: frame.height)
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.delegate = self
    }
    
    convenience init(parent: UIView, color: UIColor, text: String)
    {
        self.init(frame: CGRect(x: 0, y: 0, width: parent.frame.width, height: 100))
        self.backgroundColor = color
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: self.frame.height))
        self.leftView.backgroundColor = color
        
        self.mainView = UIView(frame: CGRect(x: 100, y: 0, width: self.frame.width, height: self.frame.height))
        self.mainView.backgroundColor = color
        
        self.mainLabel = UILabel(frame: self.frame, text: text, textColor: UIColor.whiteColor(), textAlignment: .Center, font: UIFont.systemFontOfSize(30))
        self.mainView.addSubview(self.mainLabel)
        
        self.rightView = UIView(frame: CGRect(x: self.frame.width + 100, y: 0, width: 100, height: self.frame.height))
        self.rightView.backgroundColor = color
        
        self.addSubview(self.leftView)
        self.addSubview(self.mainView)
        self.addSubview(self.rightView)
        
        self.goToMainView()
    }
    
    func addRightAction(attString: NSAttributedString, action: () -> Void)
    {
        self.rightAction = true
        self.rightActionHandler = action
        self.backgroundColor = UIColor.nephritisColor()
        
        // Set up the view
        self.rightView.backgroundColor = UIColor.nephritisColor()
        self.rightSpinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.rightSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.rightView.addSubview(self.rightSpinner)
        
        // Set up the main view label
        self.rightButton = UIButton(frame: CGRect(x: self.frame.width - 50, y: self.frame.height/2 - 25, width: 50, height: 50))
        self.rightButton.setAttributedTitle(attString, forState: .Normal)
        self.rightButton.addTarget(self, action: "goToRight", forControlEvents: .TouchUpInside)
        self.mainView.addSubview(self.rightButton)
    }
    
    func addLeftAction(attString: NSAttributedString, action: () -> Void)
    {
        self.leftAction = true
        self.leftActionHandler = action
        self.backgroundColor = UIColor.nephritisColor()
        
        // Set up the view
        self.leftView.backgroundColor = UIColor.nephritisColor()
        self.leftSpinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.leftSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.leftView.addSubview(self.leftSpinner)
        
        // Set up the main view label
        self.leftButton = UIButton(frame: CGRect(x: 0, y: self.frame.height/2 - 25, width: 50, height: 50))
        self.leftButton.setAttributedTitle(attString, forState: .Normal)
        self.leftButton.addTarget(self, action: "goToLeft", forControlEvents: .TouchUpInside)
        self.mainView.addSubview(self.leftButton)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        self.evaluateActions()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
    {
        self.evaluateActions()
    }
    
    func evaluateActions()
    {
        if self.contentOffset.x < 100
        {
            if !self.leftAction
            {
                self.goToMainView()
            }
            else
            {
                self.leftSpinner.startAnimating()
                self.leftActionHandler()
            }
        }
        else if self.contentOffset.x >= 200
        {
            if !self.rightAction
            {
                self.goToMainView()
            }
            else
            {
                self.rightSpinner.startAnimating()
                self.rightActionHandler()
            }
        }
    }
    
    func goToMainView()
    {
        if let lspin = self.leftSpinner
        {
            lspin.stopAnimating()
        }
        if let rspin = self.rightSpinner
        {
            rspin.stopAnimating()
        }
        
        self.setContentOffset(CGPoint(x: 100, y: 0), animated: true)
    }
    
    func goToRight()
    {
        self.setContentOffset(CGPoint(x: 200, y: 0), animated: true)
    }
    
    func goToLeft()
    {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
