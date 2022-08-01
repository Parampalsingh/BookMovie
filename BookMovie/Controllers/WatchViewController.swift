//
//  WatchViewController.swift
//  BookMyMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import UIKit

class WatchViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var movieModel: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieList()
        
    }
    
    func getMovieList() {
        
        let params = ["api_key":"7d9499874d7ae43e222f915dac097808"]
        
//        showLoader()
        NetworkManager.get(MovieModel.self, webpath: .movieList, params: params) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
//                self.hideLoader()
                switch response {
                case .success(let model):
                    print(model.results.count)
                    self.movieModel = model
                    print(self.movieModel.results.count)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension WatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return movieModel != nil ? movieModel.results.count : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        if movieModel != nil {
            
            cell.content = movieModel.results[indexPath.row]
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = MovieDetailViewController.initiateFromStoryboard(.watch)
        controller.content = movieModel.results[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
