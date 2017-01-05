//
//  SurveyController.swift
//  StudentAPI
//
//  Created by Steven Patterson on 7/28/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation

class SurveyController {

    static let baseURL = NSURL(string: "https://students-fe5e7.firebaseio.com/students")

    static func getResponses(completion: (surveys: [Survey])-> Void) {
        guard let url = baseURL?.URLByAppendingPathExtension("json") else {
            print("Error: No Url Found")
            completion(surveys: [])
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("ERROR: No data Found")
                    completion(surveys: [])
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: [String: AnyObject]] else {
                print("Error: Unable To Serialize JSON: \(responseDataString)")
                completion(surveys: [])
                return
            }
            let surveys = jsonDictionary.flatMap {Survey(identifier: $0.0, dictionary: $0.1)}
            completion(surveys: surveys)
            print("Success: \(responseDataString)")
        }
    }
    
    static func sendSurvey(name: String, response: String) {
        let survey = Survey(name: name, response: response)
        
        guard let url = survey.endpoint else {
            print("No URL FOUND")
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, urlParameters: nil, body: survey.jsonData) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("ERROR NO DATA FOUND")
                    return
            }
            
            if error != nil {
                print("ERROR: \(error?.localizedDescription)")
            } else if responseDataString.containsString("error") {
                print("ERROR: \(responseDataString)")
            } else {
                print("Successfully saved data to endpoint. /n \(responseDataString)")
            }
        }
    }
}