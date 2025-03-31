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
            if let data = result.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as?[String: Any]{
                self.registerLiveness(customerImageBase64: "Liveness-ImageBase64")
               print("Register Success :  \(json)")
            } else {
               print("Invalid response format: \(result)")
            }
           
        }
        
    }
    
    private func registerLiveness(customerImageBase64: String) {
        
        GACSDKApp().registerLiveness(customerImageBase64:customerImageBase64,completion: { result  in
              if let data = result.data(using: .utf8),
                 let json = try? JSONSerialization.jsonObject(with: data, options: []) as?[String: Any]{
                 print("Register Liveness Success :  \(json)")
              } else {
                 print("Invalid response format: \(result)")
              }
        })
        
    }
}

