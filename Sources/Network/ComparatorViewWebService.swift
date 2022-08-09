//
//  ComparatorViewWebService.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import Foundation
import WhiteLabel___Utils

public struct ComparatorViewWebService: ComparatorViewWebServiceProtocol {
    
    public var runningRequest: URLSessionDataTask?
    
    public init() {
        self.runningRequest = nil
    }
    
    public mutating func getInfastructures(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void) {
        // cancels the current running request
        self.runningRequest?.cancel()
        // sets the running request to nil
        self.runningRequest = nil
        // Calls the helper struct to perform the request passing the endpoint along side with the parameter
        self.runningRequest = EVIOAPIClient.shared.getRequest(urlString: .getInfrastructures, params: nil, completion: { response in
            // checks whether the response object inside the main response object exist, checks if the status code is equal to 400 and if the data object exists
            if let res = response.response, res.statusCode == HTTPStatusCode.badRequest, let data = response.data {
                do {
                    // if true then attempts to decode the message object from the data object
                    let message: EVIOServerMessage = try JSONDecoder().decode(EVIOServerMessage.self, from: data)
                    // the message object is sent back if the decoding process does not fail
                    completion(nil, message, nil)
                } catch {
                    // Otherwise the catch block is executed and gets an error object automatically which is then sent back
                    completion(nil, nil, res.statusCode)
                }
            } else if let res = response.response, res.statusCode == HTTPStatusCode.ok, let data = response.data {
                do {
                    // if true then it attempts to decode the infras object from the data object
                    let infras: [EVIOInfrastructure] = try JSONDecoder().decode([EVIOInfrastructure].self, from: data)
                    var chargers: [EVIOCharger] = []
                    for inf in infras where inf.listChargers != nil && !inf.listChargers!.isEmpty {
                        inf.listChargers!.forEach({ chargers.append($0) })
                    }
                    // the infras object is sent back if the decoding does not fail
                    completion(chargers, nil, nil)
                } catch {
                    // Otherwise the catch block is executed calling the completion block passing everything as nil and the status code as optional
                    completion(nil, nil, response.response?.statusCode)
                }
            } else {
                // The response's error is sent back
                completion(nil, nil, response.response?.statusCode)
            }
        })
    }
    
    public mutating func getOtherInfastructures(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void) {
            // cancels the current running request
            self.runningRequest?.cancel()
            // sets the running request to nil
            self.runningRequest = nil
            // Calls the helper struct to perform the request passing the endpoint along side with the parameter
            self.runningRequest = EVIOAPIClient.shared.getRequest(urlString: .getOtherInfrastructures, params: nil, completion: { response in
                // checks whether the response object inside the main response object exist, checks if the status code is equal to 400 and if the data object exists
                if let res = response.response, res.statusCode == HTTPStatusCode.badRequest, let data = response.data {
                    do {
                        // if true then attempts to decode the message object from the data object
                        let message: EVIOServerMessage = try JSONDecoder().decode(EVIOServerMessage.self, from: data)
                        // the message object is sent back if the decoding process does not fail
                        completion(nil, message, nil)
                    } catch {
                        // Otherwise the catch block is executed and gets an error object automatically which is then sent back
                        completion(nil, nil, res.statusCode)
                    }
                } else if let res = response.response, res.statusCode == HTTPStatusCode.ok, let data = response.data {
                    do {
                        // if true then it attempts to decode the infras object from the data object
                        let infras: [EVIOInfrastructure] = try JSONDecoder().decode([EVIOInfrastructure].self, from: data)
                        var chargers: [EVIOCharger] = []
                        for inf in infras where inf.listChargers != nil && !inf.listChargers!.isEmpty {
                            inf.listChargers!.forEach({ chargers.append($0) })
                        }
                        // the infras object is sent back if the decoding does not fail
                        completion(chargers, nil, nil)
                    } catch {
                        // Otherwise the catch block is executed calling the completion block passing everything as nil and the status code as optional
                        completion(nil, nil, response.response?.statusCode)
                    }
                } else {
                    // The response's error is sent back
                    completion(nil, nil, response.response?.statusCode)
                }
            })
    }
    
    public mutating func getFavourites(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void) {
        // cancels the current running request
        self.runningRequest?.cancel()
        // sets the running request to nil
        self.runningRequest = nil
        // Calls the helper struct to perform the request passing the endpoint along side with the parameter
        self.runningRequest = EVIOAPIClient.shared.getRequest(urlString: .getUserFavourites, params: nil, completion: { response in
            // checks whether the response object inside the main response object exist, checks if the status code is equal to 400 and if the data object exists
            if let res = response.response, res.statusCode == HTTPStatusCode.badRequest, let data = response.data {
                do {
                    // if true then attempts to decode the message object from the data object
                    let message: EVIOServerMessage = try JSONDecoder().decode(EVIOServerMessage.self, from: data)
                    // the message object is sent back if the decoding process does not fail
                    completion(nil, message, nil)
                } catch {
                    // Otherwise the catch block is executed and gets an error object automatically which is then sent back
                    completion(nil, nil, res.statusCode)
                }
            } else if let res = response.response, res.statusCode == HTTPStatusCode.ok, let data = response.data {
                do {
                    // if true then it attempts to decode the infras object from the data object
                    let chargers: [EVIOCharger] = try JSONDecoder().decode([EVIOCharger].self, from: data)
                    completion(chargers, nil, nil)
                } catch {
                    // Otherwise the catch block is executed calling the completion block passing everything as nil and the status code as optional
                    completion(nil, nil, response.response?.statusCode)
                }
            } else {
                // The response's error is sent back
                completion(nil, nil, response.response?.statusCode)
            }
        })
    }
    
    public mutating func cancelRequests() {
        
    }
    
}
