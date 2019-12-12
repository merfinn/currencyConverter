//
//  ConversionViewController.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 01.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet weak var conversionTableView: UITableView!
    let dataSource = ConversionDataSource()
    var conversions:[Conversion] = []
    let longPolling = LongPolling()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.conversionViewControllerTitle
        view.accessibilityIdentifier = Constants.conversionViewControllerAccesibilityIdentifier
        conversions = dataSource.getConversions()
        longPolling.pairs = dataSource.pairs
        longPolling.delegate = self
        longPolling.startPoll()
    }
    
    // MARK: - Button Actions
    @IBAction func openCurrencySelection() {
        if let viewController = UIStoryboard(name: Constants.mainName, bundle: nil).instantiateViewController(withIdentifier: Constants.currencySelectionViewControllerIdentifier) as? CurrencySelectionViewController {
            viewController.delegate = self
            viewController.conversions = conversions
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}
// MARK: - Protocols
extension ConversionViewController: CurrencySelectionViewDelegate {
    func currencyPairAdded(conversion: Conversion) {
        //add from the second selection
        conversions.append(conversion)
        dataSource.setConversions(newConversions: conversions)
        longPolling.pairs = dataSource.pairs
        conversionTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
    }
}

extension ConversionViewController: LongPollingDelegate {
    func dataRecieved(theData: Data) {
        //parse the data
        if let parsed = JSonParser.jsonParser(data: theData) {
            //match the data for view
            if(conversions.count == parsed.count && parsed.count>0) {
                for index in 0..<parsed.count{
                    if let tuple = parsed.first(where: {$0.key as! String == conversions[index].fromCurrency + (conversions[index].toCurrency ?? "")}) {
                        conversions[index].conversionRate =  String(describing: tuple.value)
                        
                        let cell = conversionTableView.cellForRow(at: IndexPath(row: index, section: 0))
                            as? ConversionTableViewCell;
                            cell?.fillData(viewModel: conversions[index])
                    }
                }
            }
        }
    }
}
// MARK: - Tableview Delegate Extensions
extension ConversionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(conversions.count>0) {
            conversionTableView.isHidden = false
            longPolling.startPoll()
        }
        else {
            conversionTableView.isHidden = true
            longPolling.stopPoll()
        }
        return conversions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ConversionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: Constants.conversionTableViewCellIdentifier) as? ConversionTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: Constants.conversionTableViewCellName, bundle: nil), forCellReuseIdentifier: Constants.conversionTableViewCellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.conversionTableViewCellIdentifier) as? ConversionTableViewCell
        }
        cell.fillData(viewModel: (conversions[indexPath.row] as Conversion))
        return cell
    }
}

extension ConversionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(conversions.count>0) {
                conversions.remove(at: indexPath.row)
                dataSource.setConversions(newConversions: conversions)
                longPolling.pairs = dataSource.pairs
                conversionTableView.beginUpdates()
                conversionTableView.deleteRows(at: [indexPath], with: .automatic)
                conversionTableView.endUpdates()
            }
            else {
                //to show the hidden very first view
                conversionTableView.reloadData()
            }
        }
    }
}
