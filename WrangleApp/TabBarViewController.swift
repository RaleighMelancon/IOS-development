//
//  TabBarViewController.swift
//  FirebaseApp
//
//  Created by Raleigh Melancon on 5/30/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        let feedImage = UIImage(named: "first")
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
        feedViewController.view.backgroundColor = ORANGE_THEME
        
        let followingViewController = FollowingViewController()
        let followingImage = UIImage(named: "second")
        followingViewController.tabBarItem = UITabBarItem(title: "Following", image: followingImage, tag: 0)
        followingViewController.view.backgroundColor = ORANGE_THEME
        
        let postViewController = PostViewController()
        let postImage = UIImage(named: "third")
        postViewController.tabBarItem = UITabBarItem(title: "Post", image: postImage, tag: 0)
        postViewController.view.backgroundColor = ORANGE_THEME
        
        let settingsViewController = SettingsViewController()
        let settingsImage = UIImage(named: "settings")
        settingsViewController.view.backgroundColor = ORANGE_THEME
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: settingsImage, tag: 0)
        
        let tabBarList = [feedViewController, followingViewController, postViewController, settingsViewController]
        
        viewControllers = tabBarList
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}


