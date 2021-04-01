//
//  ServiceManager.swift
//  GitHubUserPublicApiDemo
//
// 
//

import Foundation
import Alamofire
import UIKit

final class ServiceManager
{
    typealias CompletionHandler = (Data)->Void
    
    func MakeApiCall(url urlString: String,withParameters Parameters:[String:Any]?,httpMethod:HTTPMethod,completionHandler:@escaping CompletionHandler)
    {
        guard let url = URL.init(string: urlString) else {
            return
        }
       
        AF.request(url, method: httpMethod, parameters: Parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (Response) in
            if Response.error == nil
            {
                guard let response = Response.data else{return}
                completionHandler(response)
                print(response)
            }
            else
            {
                if let error = Response.error {
                    self.showErrorAlert(message: error.localizedDescription)
                    return
                }
            }
            
        }
    }
    
}
private extension ServiceManager {
    
    func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let app = UIApplication.shared.delegate as? SceneDelegate
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        guard let viewController = app?.window?.rootViewController else {
            return
        }
        viewController.present(alert, animated: true)
    }
}
