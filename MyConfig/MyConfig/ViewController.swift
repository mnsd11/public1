//
//  ViewController.swift
//  MyConfig
//
//  Created by DIRECTOR on 26.10.2021.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {

    
   
    
    @IBOutlet weak var urlButton: UIButton!
    
    
    
    var remoteConfig = RemoteConfig.remoteConfig()
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remoteConfig.fetchAndActivate { (status, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if status != .error {
                    if let stringURL = self.remoteConfig["backgroud_image_stringURL"].stringValue {
                        DispatchQueue.main.async {
                            self.imageView.load(stringURL: stringURL)
                        }
                    }
                }
            }
            
            
        }
    }
    
    
}


extension UIImageView {
    
    func load(stringURL : String) {
        
        if let url = URL(string: stringURL) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

