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
        navigationController?.navigationBar.prefersLargeTitles = false
        
        imgCenter.loadFrom(URLAddress: nasaDetail[0].nasaImage)
        lblTitle.text = nasaDetail[0].nasaTitle
        lblPhotographDate.text = "\(nasaDetail[0].nasaPhotographer) | \(nasaDetail[0].nasaDate)"
        lblDescription.text = nasaDetail[0].nasaDescription
    }
}
