//
//  TickMarkViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 12/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class TickMarkViewController: UIViewController {

    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataDownloaded), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    
    func dataDownloaded(notifications:NSNotification) {
//       let lvc = LoginViewController()
//        lvc.dataDownloaded(notification: notifications)
//        present(lvc, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationForDownloadDataFromInternet() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationForDownloadDataFromInternet()
   let defaults = UserDefaults.standard
    let token = defaults.value(forKey: "session") as? String
        print(token!)
        // Do any additional setup after loading the view.
        Http.httpRequest(session: token!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Http.submitAction()
        self.navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
