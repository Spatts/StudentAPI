//
//  Survey.swift
//  StudentAPI
//
//  Created by Steven Patterson on 7/28/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation

struct Survey {
    private let kName = "name"
    private let kResponse = "response"
    
    var name: String
    var response: String
    var identifier: NSUUID

    init?(identifier: String, dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
            response = dictionary[kResponse] as? String,
            identifier = NSUUID(UUIDString: identifier) else {return nil}
        
        self.name = name
        self.response = response
        self.identifier = identifier
    }
    
    
    init(name: String, response: String) {
        self.name = name
        self.response = response
        self.identifier = NSUUID()
    }
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [kName: name, kResponse: response]
    }
    
    var jsonData: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryRepresentation, options: .PrettyPrinted)
    }
    
    var endpoint: NSURL? {
    return SurveyController.baseURL?.URLByAppendingPathComponent(identifier.UUIDString).URLByAppendingPathExtension("json")
    }
}