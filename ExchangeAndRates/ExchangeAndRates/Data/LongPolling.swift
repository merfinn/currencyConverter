//
//  LongPollingDelegate.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 03.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

protocol LongPollingDelegate{
    func dataRecieved(theData:Data)
}

class LongPolling:NSObject{
    var delegate: ConversionViewController? = nil
    var pairs:[String] = []
    var stopped : Bool = true
    
    @objc func longPoll() -> Void {
        if(!stopped)
        {
            //building url
            var url = URLComponents(string: Constants.apiURL)!
            url.queryItems = []
            for conversionStr in pairs {
                url.queryItems?.append(URLQueryItem(name: Constants.apiQueryItem, value: conversionStr))
            }
            
            var response: URLResponse? = nil
            let requestUrl = url.url
            var request: URLRequest? = nil
            if let requestUrl = requestUrl {
                request = URLRequest(url: requestUrl)
            }
            
            //send the request (will block until a response comes back)
            var responseData: Data? = nil
            do {
                if let request = request {
                    responseData = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
                }
            } catch {
                print(Constants.errorMessage)
            }
            
            let selectorDataRecieved = #selector(LongPolling.dataRecieved(theData:))
            performSelector(onMainThread: selectorDataRecieved, with: responseData, waitUntilDone: true)
            
            //going too fast wait 1 second//TODO:
            sleep(1)
            
            //send the next poll request
            let selectorLongpoll = #selector(LongPolling.longPoll)
            performSelector(inBackground: selectorLongpoll, with: nil)
        }
    }
    
    func stopPoll() -> Void {
        stopped = true
    }
    
    func startPoll() -> Void {
        // ensuring that only 1 poll is active at any given time
        if(stopped) {
            stopped = false
            let selectorLongpoll = #selector(LongPolling.longPoll)
            performSelector(inBackground: selectorLongpoll, with: nil)
        }
    }
    
    @objc func dataRecieved(theData:Data) -> Void {
        //process the response here
        self.delegate?.dataRecieved(theData: theData)
    }
}
