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
        print("Error loading data from EvenSource stream. EventSource manager will try to reconnect...")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NDRSerieInfoCell") as? NDRSerieInfoCell else { return UITableViewCell() }
        
        let eventSerie = NDREventSourceReader.sharedInstacne.latestData[indexPath.row]
        cell.labelMeasurementName.text = eventSerie.name
        cell.labelMeasurementValue.text = eventSerie.actualMeasurementStringRepresentation()
    
        return cell
    }
}
