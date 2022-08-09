//
//  ComparatorViewWebServiceProtocol.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import Foundation
import WhiteLabel___Utils

public protocol ComparatorViewWebServiceProtocol {
    
    // the currently running request
    var runningRequest: URLSessionDataTask? { get set }
    
    // init
    init()
    
    // Method to get the user's infastructures
    mutating func getInfastructures(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void)
    
    // Method to get the user's other infastructures
    mutating func getOtherInfastructures(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void)
    
    mutating func getFavourites(completion: @escaping ([EVIOCharger]?, EVIOServerMessage?, Int?) -> Void)
    
    // Method that cancels the currenty running request
    mutating func cancelRequests()
    
}
