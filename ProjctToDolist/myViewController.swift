//
//  myViewController.swift
//  ProjctToDolist
//
//  Created by Osama folta on 26/03/1443 AH.
//

import UIKit

protocol passDataBack{
    func updateRow(updateName:String)
}

class myViewController: UIViewController {
    var passdata:String?
    var delegate:passDataBack!

   
    
    @IBOutlet weak var usrdata: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usrdata.text = passdata!
        
    }
    

    @IBAction func updateBTn(_ sender: Any) {
        let newdata = usrdata.text!
        delegate.updateRow(updateName: newdata)
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func Enterbtn(_ sender: Any) {
        let newdata = usrdata.text!
        delegate.updateRow(updateName: newdata)
        dismiss(animated: true, completion: nil)
    }
}
