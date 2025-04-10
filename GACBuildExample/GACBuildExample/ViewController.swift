//
//  ViewController.swift
//  GACBuildExample
//
import UIKit
import GACSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func touchRegister(_ sender: Any) {
        GACSDKApp().registerWallet { result in
            switch result {
               case .success(let response):
                    print("Register Success : \(response)")
               case .failure(let error):
                    print("Register Fail : \(error)")
               default : break
                
            }
          
        }
        
    }
    
    private func registerLiveness(customerImageBase64: String) {
        
        GACSDKApp().registerLiveness(customerImageBase64:customerImageBase64,completion: { result  in
            
            switch result {
                case .success(let response):
                      print("Register Liveness Success : \(response)")
                case .failure(let error):
                      print("Register Liveness Fail : \(error)")
                default : break
                
            }
          
        })
        
    }
}

