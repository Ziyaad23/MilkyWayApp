//
//  DetailViewController.swift
//  MilkyWay
//
//  Created by user220267 on 4/20/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nasaDetail:[NasaInfo] = []

    @IBOutlet weak var imgCenter: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPhotographDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.backButtonTitle = "The Milky Way"
        
        //imgCenter.loadFrom(URLAddress: nasaDetail[0].nasaImage)
        lblTitle.text = nasaDetail[0].nasaTitle
        lblPhotographDate.text = "\(nasaDetail[0].nasaPhotographer) | \(nasaDetail[0].nasaDate)"
        lblDescription.text = nasaDetail[0].nasaDescription
        
        print(nasaDetail[0].nasaDescription)
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
