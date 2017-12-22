//
//  FCCInformation.swift
//  Comms
//
//  Created by Anthony Picciano on 12/22/17.
//  Copyright © 2017 Anthony Picciano. All rights reserved.
//

import Foundation

struct FCCInformation: Codable {
    let status: Status
    let type: Type
    let current: License
    let previous: License
    let trustee: Trustee
    let name: String
    let address: Address
    let location: Location
    let otherInfo: OtherInfo
}

struct Trustee: Codable {
    let callsign: String
    let name: String
}

struct OtherInfo: Codable {
    let grantDate: String
    let expiryDate: String
    let lastActionDate: String
    let frn: String
    let ulsUrl: URL
}

struct Location: Codable {
    let latitude: String
    let longitude: String
    let gridsquare: String
}

struct License: Codable {
    let callsign: String
    let operClass: OperClass
}

struct Address: Codable {
    let line1: String
    let line2: String
    let attn: String
}

enum OperClass: String, Codable {
    case extra = "EXTRA"
    case general = "GENERAL"
    case technician = "TECHNICIAN"
    case advanced = "ADVANCED"
    case novice = "NOVICE"
    case none = ""
}

enum Type: String, Codable {
    case person = "PERSON"
    case club = "CLUB"
}

enum Status: String, Codable {
    case valid = "VALID"
}

// MARK: Top-level extensions -

extension FCCInformation {
    static func from(callsign: String, completion: @escaping ((FCCInformation?) -> ())) {
        let urlString = "https://callook.info/\(callsign)/json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                let fccInformation = FCCInformation.from(data: data)
                DispatchQueue.main.async {
                    completion(fccInformation)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}

extension FCCInformation {
    static func from(json: String, using encoding: String.Encoding = .utf8) -> FCCInformation? {
        guard let data = json.data(using: encoding) else { return nil }
        return from(data: data)
    }
    
    static func from(data: Data) -> FCCInformation? {
        let decoder = JSONDecoder()
        return try? decoder.decode(FCCInformation.self, from: data)
    }
    
    static func from(url urlString: String) -> FCCInformation? {
        guard let url = URL(string: urlString) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return from(data: data)
    }
    
    var jsonData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    var jsonString: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: Codable extensions -

extension FCCInformation {
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case type = "type"
        case current = "current"
        case previous = "previous"
        case trustee = "trustee"
        case name = "name"
        case address = "address"
        case location = "location"
        case otherInfo = "otherInfo"
    }
}

extension Trustee {
    enum CodingKeys: String, CodingKey {
        case callsign = "callsign"
        case name = "name"
    }
}

extension OtherInfo {
    enum CodingKeys: String, CodingKey {
        case grantDate = "grantDate"
        case expiryDate = "expiryDate"
        case lastActionDate = "lastActionDate"
        case frn = "frn"
        case ulsUrl = "ulsUrl"
    }
}

extension Location {
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case gridsquare = "gridsquare"
    }
}

extension License {
    enum CodingKeys: String, CodingKey {
        case callsign = "callsign"
        case operClass = "operClass"
    }
}

extension Address {
    enum CodingKeys: String, CodingKey {
        case line1 = "line1"
        case line2 = "line2"
        case attn = "attn"
    }
}
