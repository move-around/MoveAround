//
//  DiscoverViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var manualImage: UIImageView!
    @IBOutlet weak var quickImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let archetypeArray =
        [Archetype(name: "Foodie", imageName: "foodie", description: "Interested in food and beverages.  Seeks new food experiences as a hobby."),
         Archetype(name: "Night Owl", imageName: "nightowl", description: "Stays up late. Participates in noctural activities."),
         Archetype(name: "Adventurer", imageName: "adventurer", description: "Engages in adventures and active exercises."),
         Archetype(name: "Touristy", imageName: "touristy", description: "Enjoys attractions of cultural value or historical significance."),
         Archetype(name: "Unique", imageName: "unique", description: "Finds leisure in off the beaten path experiences."),
         Archetype(name: "Artistic", imageName: "artsy", description: "Enthusiastic about the arts.  Enjoys cultural exhibitions."),
         Archetype(name: "Thrifty", imageName: "budget", description: "Travelling on a budget and looking for deals.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        manualImage.tintColorDidChange()
        quickImage.tintColorDidChange()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archetypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchetypeCell") as! ArchetypeCell
        let archetype = archetypeArray[indexPath.row]
        cell.nameLabel.text = archetype.name
        cell.posterImage.image = UIImage(named: archetype.imageName)
        cell.descriptionLabel.text = archetype.description
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
