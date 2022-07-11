//
//  ViewController.swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
        
    var movieList = [Movie]()
    var watchedArray = [Movie]()
    var unwatchedArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMovieList()
        tableView.delegate = self
        tableView.dataSource = self

        watchedArray = movieList.filter({$0.seen == true })
        unwatchedArray = movieList.filter({$0.seen == false })
    }
    
    func makeMovieList() {
        for i in 0..<titlesAndActorsDictionary.count {
            let title = titlesAndActorsDictionary.keys.map{$0}[i]
            let actor = titlesAndActorsDictionary.values.map{$0}[i]
            movieList.append(Movie(image: UIImage(named: title), title: title, releaseDate: "\(Int.random(in: 2005...2022))", imdb: Double.random(in: 0...5), mainActor: actor, seen: Bool.random(), isFavourite: Bool.random()))
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, MovieListDelegate {
    
    func changeSection(for cell: MovieListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if indexPath.section  == 0 {
            var chooseCell = watchedArray[indexPath.row]
            chooseCell.seen = !chooseCell.seen
            watchedArray.remove(at: indexPath.row)
            unwatchedArray.append(chooseCell)
            tableView.reloadData()
        } else {
            var chooseCell = unwatchedArray[indexPath.row]
            chooseCell.seen = !chooseCell.seen
            unwatchedArray.remove(at: indexPath.row)
            watchedArray.append(chooseCell)
            tableView.reloadData()
        }
        
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            if section == 0 {
                return watchedArray.count
            } else {
                return unwatchedArray.count
            }
        }
        func numberOfSections(in tableView: UITableView) -> Int { 2 }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell
            if let cell = cell {
            if indexPath.section == 0 {
               
                
                cell.configure(with: watchedArray[indexPath.row])
                cell.movieDelegate = self
                return cell
            } else {
                cell.configure(with: unwatchedArray[indexPath.row])
                cell.movieDelegate = self
                return cell
               }
            }else { return UITableViewCell()
            
            }
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            170
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Watched Movies"
            } else {
               return  "Unwatched Movies"
            }
        }
}

    
