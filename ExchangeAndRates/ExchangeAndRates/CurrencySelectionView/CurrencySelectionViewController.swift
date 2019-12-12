//
//  CurrencySelectionViewController.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 31.10.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

protocol CurrencySelectionViewDelegate{
    func currencyPairAdded(conversion:Conversion)
}

class CurrencySelectionViewController: UIViewController {
    
    @IBOutlet weak var currencySelectionTableView: UITableView!
    var delegate: CurrencySelectionViewDelegate? = nil
    var currencyList : NSArray!
    var conversions : [Conversion]!
    var isFromCurrency : Bool = false
    var conversion:Conversion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //take the data from the file
        currencyList = JSonParser.jsonFromFile(resource: Constants.currenciesFileName, extension: Constants.currenciesFileType) ?? []
        view.accessibilityIdentifier = Constants.currencyViewControllerAccesibilityIdentifier
        title = isFromCurrency ? "Second Currency" : "First Currency"
    }
    //MARK: - OTHER
    func decideWhetherEnable(cellCurrency:String)->Bool { 
        if isFromCurrency { //second selection view
            var pairs = conversions.filter( {$0.fromCurrency == conversion.fromCurrency }).map({ return $0.toCurrency })
            pairs.append(conversion.fromCurrency)
            return !pairs.contains(cellCurrency)
        }
        else{
            return true
        }
    }
}
// MARK: - Tableview Delegate Methods
extension CurrencySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromCurrency {
            let selectedToCurrency = currencyList.object(at: indexPath.row) as! String
            conversion = Conversion(fromCurrency: conversion.fromCurrency, toCurrency: selectedToCurrency)
            delegate?.currencyPairAdded(conversion: conversion)
            navigationController?.popToRootViewController(animated: true)
        }
        else if let viewController = UIStoryboard(name: Constants.mainName, bundle: nil).instantiateViewController(withIdentifier: Constants.currencySelectionViewControllerIdentifier) as? CurrencySelectionViewController{
            viewController.isFromCurrency = true
            viewController.delegate = delegate
            let selectedFromCurrency = currencyList.object(at: indexPath.row) as! String
            viewController.conversion = Conversion(fromCurrency: selectedFromCurrency)
            viewController.conversions = conversions
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.currencySelectionRowHeight)
    }
}

extension CurrencySelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CurrencyTableViewCell! = tableView.dequeueReusableCell(withIdentifier: Constants.currencyTableViewCellIdentifier) as? CurrencyTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: Constants.currencyTableViewCellName, bundle: nil), forCellReuseIdentifier: Constants.currencyTableViewCellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.currencyTableViewCellIdentifier) as? CurrencyTableViewCell
        }
        let currencyText = currencyList.object(at: indexPath.row)
        cell.fillData(viewModel: currencyText as! String)
        cell.isUserInteractionEnabled = decideWhetherEnable(cellCurrency: currencyText as! String)
        if !cell.isUserInteractionEnabled {
            cell.currencyImageView.backgroundColor = UIColor.lightGray
        }
        return cell
    }
}
