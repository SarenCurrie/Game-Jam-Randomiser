//
//  Dice.swift
//  Simple Dice
//
//  Created by Saren Currie on 13/07/14.
//  Copyright (c) 2014 Saren Currie. All rights reserved.
//

import Foundation

protocol Dice {
	func roll() -> Int
	func stringValue() -> String
}

func basicRoll(val: Int) -> Int {
	let r = Int((arc4random_uniform(UInt32(val)) + 1))
	return r
}

class BasicDice: NSObject, Dice {
	let _value: Int
	
	init(value: Int) {
		_value = value;
	}
	
	func stringValue() -> String {
		return "D\(_value)"
	}
	
	func roll() -> Int {
		return basicRoll(_value)
	}
}

class MultiDice: NSObject, Dice {
	let _value: Int
	let _multi: Int
	
	init(value: Int, multiple: Int) {
		_value = value
		_multi = multiple
	}
	
	func stringValue() -> String {
		return "\(_multi)D\(_value)"
	}
	
	func roll() -> Int {
		var result = 0
		for index in 1..._multi {
			result += basicRoll(_value)
		}
		return result
	}
}

class RiggedDice: BasicDice {
	var modifier: Int = 0
	override func roll() -> Int {
		if _value < 4 {
			modifier = 0
		}
		else if _value < 8 {
			modifier = 1
		}
		else if _value < 15 {
			modifier = 2
		}
		else if _value < 25 {
			modifier = 4
		}
		else if _value < 40 {
			modifier = 6
		}
		else if _value < 60 {
			modifier = 8
		}
		else {
			modifier = 12
		}
		return basicRoll(_value - modifier) + modifier
	}
}