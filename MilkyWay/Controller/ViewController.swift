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
    
    var viewModel: UsersViewModel!
    var nasaInfos: [NasaInfo] = []
    
    private let apiManager = APIManager()
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
        viewModel = UsersViewModel(apiManager: apiManager)
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
                    let nasaId = item.data[0].nasaID ?? ""
                    let nasaTitle = item.data[0].title ?? ""
                    let nasaImage = item.links[0].href ?? ""
                    let nasaDescription = item.data[0].description ?? ""
                    let nasaCenter = item.data[0].center ?? ""
                    let nasaDateCreated = item.data[0].date_created ?? ""
                    print(nasaDateCreated)

                    //Date Formatter to required format
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd"
                    let _date = dateFormatterGet.date(from: nasaDateCreated)
                    let dateCreated =  dateFormatterPrint.string(from: _date ?? Date())

                    let resultsToAppend = NasaInfo(nasaId: nasaId, nasaImage: nasaImage, nasaTitle: nasaTitle, nasaDescription: nasaDescription, nasaCenter: nasaCenter, nasaDate: dateCreated)
                    
                    self.nasaInfos.append(resultsToAppend)
                }
                print(self.nasaInfos)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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

protocol APIManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}
