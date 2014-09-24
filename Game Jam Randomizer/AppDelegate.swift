//
//  AppDelegate.swift
//  Game Jam Randomizer
//
//  Created by Saren Currie on 31/07/14.
//  Copyright (c) 2014 Saren Currie. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
	@IBOutlet var window: NSWindow!
	@IBOutlet var themeField: NSTextField!
	@IBOutlet var thingField: NSTextField!
	@IBOutlet var numberOfThemes: NSMatrix!
	
	var log = ""
	
	var themes : [String] = []
	var things : [String] = []
	var themeSize : Int = 0
	var thingSize : Int = 0
	
	func applicationDidFinishLaunching(aNotification: NSNotification?) {
		let bundle = NSBundle.mainBundle()
		let themePath = bundle.pathForResource("Themes", ofType: "txt")
		let thingPath = bundle.pathForResource("Things", ofType: "txt")
		
		themes = (NSString(contentsOfFile: themePath!, encoding: NSUTF8StringEncoding, error: nil) as String).componentsSeparatedByString("\n")
		things = (NSString(contentsOfFile: thingPath!, encoding: NSUTF8StringEncoding, error: nil) as String).componentsSeparatedByString("\n")
		
		themeSize = themes.endIndex
		thingSize = things.endIndex
		
	}

	func applicationWillTerminate(aNotification: NSNotification?) {
		// Insert code here to tear down your application
	}

	@IBAction func randomize(sender: AnyObject) {
		generateTheme()
		generateThings(numberOfThemes.selectedColumn + 1)
		NSLog(log)
		
	}
	
	func generateTheme() {
		var theme: String
		do {
			theme = themes[Int(arc4random_uniform(UInt32(themeSize)))]
		} while theme.hasPrefix("#") || theme.isEmpty
		themeField.stringValue = theme
		
		log += "Theme: \(theme), "
		
	}
	
	func generateThings(number: Int) {
		//Now supports #comments
		if number == 1 {
			var thing1 : String
			do {
				thing1 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing1.hasPrefix("#") || thing1.isEmpty
			thingField.stringValue = "\(thing1)"
			log += "Thing: \(thing1)"
		}
		else if number == 2 {
			var thing1 : String
			do {
				thing1 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing1.hasPrefix("#") || thing1.isEmpty
			var thing2 : String
			do {
				thing2 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing2 == thing1 || thing2.hasPrefix("#") || thing2.isEmpty
			thingField.stringValue = "\(thing1), \(thing2)"
			log += "Things: \(thing1), \(thing2)"
		}
		else if number == 3 {
			var thing1 : String
			do {
				thing1 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing1.hasPrefix("#") || thing1.isEmpty
			var thing2 : String
			do {
				thing2 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing2 == thing1 || thing2.hasPrefix("#") || thing2.isEmpty
			var thing3 : String
			do {
				thing3 = things[Int(arc4random_uniform(UInt32(thingSize)))]
			} while thing3 == thing1 || thing3 == thing2 || thing3.hasPrefix("#") || thing3.isEmpty
			thingField.stringValue = "\(thing1), \(thing2), \(thing3)"
			log += "Things: \(thing1), \(thing2), \(thing3)"
		}
	}

}

