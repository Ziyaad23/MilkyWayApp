//
//  DetailViewController.swift
//  MilkyWay
//
//  Created by user220267 on 4/20/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nasaDetail:[NasaInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.backButtonTitle = "The Milky Way"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
