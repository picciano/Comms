//
//  Callsign.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import Foundation

typealias Callsign = String

extension String {
    
    static var anonymous: String {
        return "X\(String.random(withLength: 5, fromCharacters: "ABCDEFGHJKLMNOPQRSTUVWXYZ23456789"))"
    }
    
    func phonetically() -> String {
        return flatMap { Callsign.phonetics[$0] }.joined(separator: "-")
    }
    
    private static let phonetics = [ "A" as Character : "alpha",
                                     "B" as Character : "bravo",
                                     "C" as Character : "charlie",
                                     "D" as Character : "delta",
                                     "E" as Character : "echo",
                                     "F" as Character : "foxtrot",
                                     "G" as Character : "golf",
                                     "H" as Character : "hotel",
                                     "I" as Character : "india",
                                     "J" as Character : "juliet",
                                     "K" as Character : "kilo",
                                     "L" as Character : "lima",
                                     "M" as Character : "mike",
                                     "N" as Character : "november",
                                     "O" as Character : "oscar",
                                     "P" as Character : "papa",
                                     "Q" as Character : "quebec",
                                     "R" as Character : "romeo",
                                     "S" as Character : "sierra",
                                     "T" as Character : "tango",
                                     "U" as Character : "uniform",
                                     "V" as Character : "victor",
                                     "W" as Character : "whiskey",
                                     "X" as Character : "xray",
                                     "Y" as Character : "yankee",
                                     "Z" as Character : "zulu",
                                     "0" as Character : "zero",
                                     "1" as Character : "one",
                                     "2" as Character : "two",
                                     "3" as Character : "three",
                                     "4" as Character : "four",
                                     "5" as Character : "five",
                                     "6" as Character : "six",
                                     "7" as Character : "seven",
                                     "8" as Character : "eight",
                                     "9" as Character : "niner"]
}

fileprivate extension String {
    
    fileprivate static let randomSeeded: Bool = {
        srandom(UInt32(time(nil)))
        return true
    }()
    
    fileprivate static func getRandomNumber(_ min: Int, _ max: Int) -> Int {
        guard String.randomSeeded else {
            fatalError()
        }
        
        return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
    }
    
    static func random(withLength length: Int = 32,
                       fromCharacters characters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        var result = String()
        
        repeat {
            result.append(characters.randomCharacter())
        } while result.count < length
        
        return result
    }
    
    fileprivate func randomCharacter() -> String.Element {
        let randomIndex: String.Index = index(startIndex,
                                              offsetBy: String.getRandomNumber(0, count - 1))
        return self[randomIndex]
    }
}

