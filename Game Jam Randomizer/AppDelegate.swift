/*
 * Game Jam Randomizer - Draws Random Themes and Things From a List.
 * Copyright (C) 2014 Saren Currie
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
	@IBOutlet var window: NSWindow!
	@IBOutlet var themeField: NSTextField!
	@IBOutlet var thingField: NSTextField!
	@IBOutlet var numberOfThemes: NSMatrix!
	
	let stderr = NSFileHandle.fileHandleWithStandardError()
	var log: String = ""
	
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
		log = ""
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
	
	func printErr(s: String) {
		stderr.writeData(s.dataUsingEncoding(NSUTF8StringEncoding)!)
	}

}

