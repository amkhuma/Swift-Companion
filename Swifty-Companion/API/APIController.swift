//
//  APIController.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/15.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import Foundation


public class APIController
{
    static var TOKEN : String = ""
    let key = "xxxxxxxxxxxxxxxxxxxxxx"
    let secret = "xxxxxxxxxxxxxxxxxxxxxx"
    static var USER : User!

    
    func getUserData(loginName: String, with success : @escaping (Data) -> (Void), with erroring : @escaping (Error) -> (Void))
    {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(loginName.lowercased())")
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(APIController.TOKEN)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if let err = error{
                DispatchQueue.main.async {
                    erroring(err)
                }
            }
            else if let d = data{
                DispatchQueue.main.async {
                    success(d)
                }
            }
        }
        task.resume()
    }
    
    func getToken(with success : @escaping (Data) -> (Void), with erroring : @escaping (Error) -> (Void) )
    {
        let bearer = ((self.key + ":" + self.secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token?")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data,response,error) in
            if let err = error {
                DispatchQueue.main.async {
                    erroring(err)
                }
            }
            else if let d = data {
                DispatchQueue.main.async {
                    success(d)
                }
            }
        }
        task.resume()
    }
}
