//
//  MovieListTableViewCell.swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import UIKit

protocol MovieListDelegate {
    func changeSection(for cell: MovieListTableViewCell)
}

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var imdbLb: UILabel!
    @IBOutlet weak var watchedOrNot: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var movieDelegate: MovieListDelegate!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func wotchedOrNotBtn(_ sender: UIButton) {
       
        movieDelegate?.changeSection(for: self)

        
    }
    
    public func configure(with item: Movie){
         poster.image = item.image
         titleLb.text = item.title
         imdbLb.text = "IMDB: \(item.imdb)"
         if item.seen {
             watchedOrNot.setTitle("watched", for: UIControl.State.normal)} else {
                 watchedOrNot.setTitle("Must Watch", for: UIControl.State.normal)
             }
     }
    
}
