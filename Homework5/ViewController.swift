//
//  ViewController.swift
//  Homework5
//
//  Created by Bohdan on 28.01.2020.
//  Copyright © 2020 HorBog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func firstAction(_ sender: Any) {
        let url = "https://838af228-12d7-4680-9a7c-e61a801ed035.mock.pstmn.io/usr-1"
        makeRequest(url: url)
    }
    
    @IBAction func secondAction(_ sender: Any) {
        let url = "https://838af228-12d7-4680-9a7c-e61a801ed035.mock.pstmn.io/value"
        makeRequest(url: url)
    }
    
    @IBAction func thirdAction(_ sender: Any) {
        let url = "https://838af228-12d7-4680-9a7c-e61a801ed035.mock.pstmn.io/status"
        makeRequest(url: url)
    }
    
    func setLabel(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.label.text = text
        }
    }
    
    private func makeRequest(url: String) {
        load(url: url) { [weak self] str, error in
            guard error == nil,
                let text = str else {
                    self?.setLabel("Error")
                    return
            }
            
            self?.setLabel(text)
        }
    }
    
    private func load (url: String, completionHandler: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        let dataTask =
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let data = data else { return }
                let str = String(decoding: data, as: UTF8.self)
        
                completionHandler(str, nil)
        }
        
        dataTask.resume()
    }
}

