//
//  NDRInfoViewController.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/22/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

import UIKit

class NDRInfoViewController: UIViewController {

    @IBOutlet weak var tableDataInfo: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NDREventSourceReader.sharedInstacne.delegate = self
        NDREventSourceReader.sharedInstacne.startListening(from: URL(string: "https://jsdemo.envdev.io/sse"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - NDREventSourceReaderListener delegate methods
extension NDRInfoViewController: NDREventSourceReadarListener {
    func eventSourceReaderDidEstablishConnection() {
        print("Connection established")
    }
    
    func eventSourceReaderDidReceiveNewDataPackage() {
        DispatchQueue.main.async {
            self.tableDataInfo.reloadData()
        }
    }
    
    func eventSourceReaderDidReceiveError() {
        print("Connection error")
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource delegate methods
extension NDRInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NDREventSourceReader.sharedInstacne.latestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "infoTableCell")!
        
        let eventSerie = NDREventSourceReader.sharedInstacne.latestData[indexPath.row]
        cell.textLabel?.text = eventSerie.rawInfo()
    
        
        return cell
    }
    
    
}
