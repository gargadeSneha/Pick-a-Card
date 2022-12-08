//
//  ViewController.swift
//  Cards
//
//  Created by TryCatch Classes on 18/10/22.
// https://official-joke-api.appspot.com/random_joke

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var array = [NSDictionary](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    }
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    
    let cards = ["1",
                 "2",
                 "3",
                 "4",
                 "5",
                 "6",
                 "7",
                 "8",
                 "9",
                 "10",
                 "11",
                 "12",
                 "13",
                 "14",
                 "15",
                 "16",
                 "17",
                 "18",
                 "19",
                 "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
     /*   guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    print(jsondata)
                }catch {
                    print("Somthing went wrong")
                }
            }
        }.resume() */
        
    }

    @IBAction func pickBtnTapped(_ sender: UIButton) {
      
        self.array.removeAll()
        
        //pick random card
        cardImg.image = UIImage(named: cards.randomElement()!)
        
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                    self.array.append(jsondata)
                    print(jsondata)
                }catch {
                    print("Somthing went wrong")
                }
            }
        }.resume()
        
    }
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTVC
        cell.label1.text = String(array[indexPath.row].value(forKey: "punchline") as! String)
        cell.label2.text = String(array[indexPath.row].value(forKey: "setup") as! String)
        
        return cell
    }
    
    
}

