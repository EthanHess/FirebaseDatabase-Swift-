//
//  Constants.swift
//  Firedatabase-Swift-
//
//  Created by Ethan Hess on 3/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

//Keys
let base64Key = "base64String"
let nameKey = "nameString"
let DOBKey = "dob"

//firebase
let firebase = Firebase(url:"https://personlist-swift.firebaseio.com")

func applyTheme() {
    
    let sharedApplication = UIApplication.sharedApplication()
    sharedApplication.delegate?.window??.tintColor = mainColor
    sharedApplication.statusBarStyle = UIStatusBarStyle.LightContent
    

    styleForNavigationBar()
    styleForTableView()
}

func styleForNavigationBar() {
    
    UINavigationBar.appearance().barTintColor = barTintColor
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: standardTextFont,  NSForegroundColorAttributeName: UIColor.whiteColor()]
}

func styleForTableView() {
    
    UITableView.appearance().backgroundColor = backgroundColor
    UITableView.appearance().separatorStyle = .SingleLine
}

func formatDate(date: NSDate) ->  String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let dateStr = dateFormatter.stringFromDate(date)
    return dateStr
}


var mainColor: UIColor {
    return UIColor(red: 215.0/255.0, green: 100.0/255.0, blue: 76.0/255.0, alpha: 1.0)
}

var barTintColor: UIColor {
    return UIColor(red: 215.0/255.0, green: 100.0/255.0, blue: 76.0/255.0, alpha: 1.0)
}

var barTextColor: UIColor {
    return UIColor(red: 254.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}

var backgroundColor: UIColor {
    return UIColor(red: 251.0/255.0, green: 243.0/255.0, blue: 241.0/255.0, alpha: 1.0)
}

var secondaryColor: UIColor {
    return UIColor(red: 251.0/255.0, green: 243.0/255.0, blue: 241.0/255.0, alpha: 1.0)
}

var textColor: UIColor {
    return UIColor(red: 63.0/255.0, green: 62.0/255.0, blue: 61.0/255.0, alpha: 1.0)
}

var headingTextColor: UIColor {
    return UIColor(red: 44.0/255.0, green: 45.0/255.0, blue: 40.0/255.0, alpha: 1.0)
}

var subtitleTextColor: UIColor {
    return UIColor(red: 156.0/255.0, green: 155.0/255.0, blue: 150.0/255.0, alpha: 1.0)
}

var standardTextFont: UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: 15)!
}

var subtitleFont: UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: 15)!
}

var headlineFot: UIFont {
    return UIFont(name: "HelveticaNeue-Bold", size: 15)!
}