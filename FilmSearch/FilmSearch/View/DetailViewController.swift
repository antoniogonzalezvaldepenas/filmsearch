//
//  DetailViewController.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var auxView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    public var movie: Title!
    private var filmData : FilmModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        trailerButton.layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
        auxView.layer.cornerRadius = 2
        contentView.isHidden = true
        
        mainImage.imageFrom(url: URL(string: movie.image!)!, completed: {
            self.activityIndicator.stopAnimating()
        })
        
        getFilms(movieId: movie.id!, completed: {_ in 
            self.titleLabel.text = self.filmData.title
            self.plotLabel.text = self.filmData.plot
            self.trailerButton.isUserInteractionEnabled = true
            self.yearLabel.text = self.filmData.year
            self.durationLabel.text = self.filmData.length
            self.ratingLabel.text = self.filmData.rating
            self.countLabel.text = ("\(self.filmData.ratingVotes ?? "0") votes")
            self.contentView.isHidden = false
        })
    }
    
    // MARK: - Get Details
    func getFilms(movieId: String, completed: @escaping (FilmModel) -> ()){
        let url = URL(string: "https://imdb-internet-movie-database-unofficial.p.rapidapi.com/film/\(movieId)?rapidapi-key=1986e168b2msh03246b6ee2ee6cbp12e0b8jsnfa08fdd6e7a5")
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error == nil {
                do{
                    let models = try JSONDecoder().decode(FilmModel.self, from: data!)
                    self.filmData = models
                    
                    DispatchQueue.main.async {
                        completed(models)
                    }
                }catch{
                    print("JSON Error \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    //MARK: - @IBActions
    @IBAction func trailerTapped(_ sender: Any) {
        if let url = URL(string: (self.filmData.trailer?.link)!) {
            UIApplication.shared.open(url)
        }
    }
    

}
