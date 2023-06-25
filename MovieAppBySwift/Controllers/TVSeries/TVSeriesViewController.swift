//
//  TVSeriesViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/23.
//

import UIKit

class TVSeriesViewController: UIViewController {

    var seriesID: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        print("Series ID>>>>>>>>>>", seriesID)
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
