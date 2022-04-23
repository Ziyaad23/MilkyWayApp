//
//  ViewController.swift
//  MilkyWay
//
//  Created by user220267 on 4/23/22.
//

import UIKit
import Combine

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NasaViewModel!
    var nasaInfos: [NasaInfo] = []
    var index = Int()
    
    private let networkManager = NetworkManager()
    private var subscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "The Milky Way"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViewModel()
        fetchResults()
        observeViewModel()
    }
    
    private func setupViewModel() {
        viewModel = NasaViewModel(NetworkManager: networkManager)
    }
    
    private func fetchResults() {
        viewModel.fetchResults()
    }
    
    private func observeViewModel() {
        subscriber = viewModel.nasaSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (users) in
            DispatchQueue.main.async {
                for item in users.collection.items{
                    let nasaId = item.data[0].nasa_id ?? ""
                    let nasaTitle = item.data[0].title ?? ""
                    let nasaImage = item.links[0].href ?? ""
                    let nasaDescription = item.data[0].description ?? ""
                    let nasaCenter = item.data[0].center ?? ""
                    let nasaDateCreated = item.data[0].date_created ?? ""
                    let nasaPhotographer = item.data[0].photographer ?? ""

                    //Date Formatter to required format
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MMM-dd"
                    let _date = dateFormatterGet.date(from: nasaDateCreated)
                    let dateCreated =  dateFormatterPrint.string(from: _date ?? Date())

                    let resultsToAppend = NasaInfo(nasaId: nasaId, nasaImage: nasaImage, nasaTitle: nasaTitle, nasaDescription: nasaDescription, nasaCenter: nasaCenter, nasaDate: dateCreated, nasaPhotographer: nasaPhotographer)
                    
                    self.nasaInfos.append(resultsToAppend)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell") as! TableViewCell
        cell.lblTitle?.text = nasaInfos[indexPath.row].nasaTitle
        cell.lblPhotographDate?.text = "\(nasaInfos[indexPath.row].nasaPhotographer) | \(nasaInfos[indexPath.row].nasaDate)"
        cell.imgCenter?.loadFrom(URLAddress: nasaInfos[indexPath.row].nasaImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if segue.identifier == "detailSegue" {
                if let nextViewController = segue.destination as? DetailViewController {
                    let infoToAppend = nasaInfos[index]
                    nextViewController.nasaDetail.append(infoToAppend)
                }
            }
        }
}

protocol NetworkManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
