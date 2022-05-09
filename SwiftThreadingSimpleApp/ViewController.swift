//
//  ViewController.swift
//  SwiftThreadingSimpleApp
//
//  Created by test on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        callBackgroundWork()
    }
    
    func callBackgroundWork(){
        DispatchQueue.global(qos: .unspecified).async {
            // do stuff here
        }
    }
    
    func getData(){
        guard let url = URL(string: "") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            
            guard data != nil else{
                return
            }
            
            // bad decision to leave it just like that because we get delayed response
            // completion handler occurs on the background thread
            // self?.view.backgroundColor = .red
            
            DispatchQueue.main.async {
                self?.view.backgroundColor = .red
            }
        })
        
        task.resume()
    }

}
