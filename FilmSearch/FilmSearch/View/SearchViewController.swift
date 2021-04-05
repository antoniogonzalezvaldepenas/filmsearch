//
//  SearchViewController.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var movieData : SearchModel!
    private var isSearchBarEditing: Bool = false
    private var selectedSection: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        activityIndicator.stopAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Search"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.topItem?.title = "Search"
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "AccentColor")
        self.navigationController?.navigationBar.barStyle = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "AccentColor")!]
    }
    
    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count > 2){
            activityIndicator.startAnimating()
            tableView.isHidden = true
            getMovies(movie: searchText, completed: {data in
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                print(self.movieData.titles![0].title ?? "Error")
                self.tableView.reloadData()
            })
        }else{
            tableView.isHidden = true
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        tableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    // MARK: - Get Movies
    func getMovies(movie: String, completed: @escaping (SearchModel) -> ()){
        let modifiedMovie = movie.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://imdb-internet-movie-database-unofficial.p.rapidapi.com/search/\(modifiedMovie)?rapidapi-key=1986e168b2msh03246b6ee2ee6cbp12e0b8jsnfa08fdd6e7a5")
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error == nil {
                do{
                    let models = try JSONDecoder().decode(SearchModel.self, from: data!)
                    self.movieData = models
                    
                    DispatchQueue.main.async {
                        completed(models)
                    }
                }catch{
                    print("JSON Error 1 \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    // MARK: - TableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if(self.movieData?.titles != nil){
            return self.movieData.titles!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.cellImage.isHidden = true
        if(self.movieData.titles != nil){
            
            //Set image background
            let cellBackground = UIImageView(image: UIImage(named: "cellBackground"))
            cellBackground.contentMode = .scaleAspectFill
            cell.backgroundView = cellBackground
            
            //Set content
            cell.layer.cornerRadius = 10
            cell.cellLabel.text = self.movieData.titles![indexPath.section].title
            cell.cellImage.imageFrom(url: URL(string: self.movieData.titles![indexPath.section].image!)!, completed: {
                    cell.cellImage.isHidden = false
            })
        
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSection = indexPath.section
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailViewController
        vc?.movie = self.movieData.titles![self.selectedSection]
    }

}

// MARK: - Set custom image from URL
extension UIImageView{
    func imageFrom(url:URL, completed: @escaping () -> ()){
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
            completed()
          }
        }
      }
    }
  }
}
