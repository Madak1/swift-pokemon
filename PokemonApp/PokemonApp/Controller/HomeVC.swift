//
//  HomeVC.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: UI components
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var typeSelectTextField: UITextField!
    @IBOutlet var checkBox: PokeCheckBox!
    @IBOutlet var tableView: UITableView!
    var tableViewSpinner = UIActivityIndicatorView()
    var typePickerView = UIPickerView()
    
    // MARK: Variables
    
    private let pokeManager: PokeManager = PokeManager()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSpinner()
        self.getPokemonTypes()
        self.getPokemons()
    }
    
    // MARK: Get Pokemons and types
    
    private func getPokemonTypes() {
        self.pokeManager.fetchPokemonTypes()
        self.pokeManager.onTypesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.setupPicker()
            }
        }
    }
    
    private func getPokemons() {
        self.pokeManager.fetchPokemons()
        self.pokeManager.onPokemonsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableViewSpinner.stopAnimating()
            }
        }
    }
    
    // MARK: Setup Loading Spinner
    
    private func setupSpinner() {
        view.addSubview(tableViewSpinner)
        
        tableViewSpinner.style = .large
        tableViewSpinner.color = .gray
        tableViewSpinner.hidesWhenStopped = true
        tableViewSpinner.startAnimating()
        
        tableViewSpinner.translatesAutoresizingMaskIntoConstraints = false
        tableViewSpinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        tableViewSpinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    // MARK: Setup Type Picker
    
    private func setupPicker() {
        typeSelectTextField.inputView = typePickerView
        typePickerView.delegate = self
        typePickerView.dataSource = self
    }
    
    // MARK: Filtering Pokemons
    
    private func startFiltering() {
        let nameFilter = searchBar.text ?? ""
        let typeFilter = typeSelectTextField.text ?? ""
        let statusFilterOn = (self.checkBox.tag == 1)
        pokeManager.filteringPokemonsBy(name: nameFilter, type: typeFilter, status: statusFilterOn)
    }

    @IBAction func searchHandler(_ sender: UITextField) {
        self.startFiltering()
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        sender.tag == 0 ? checkBox.onStyle() : checkBox.offStyle()
        self.startFiltering()
    }
    
    // MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailVC
        destVC.delegate = self
        destVC.pokemon = sender as? Pokemon
    }
    
}

// MARK: Pokemon TableView

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeManager.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCell.identifier) as? PokeCell else {
            fatalError("Unable to dequeue PokeCell in HomeVC")
        }
        cell.delegate = self
        cell.configure(with: pokeManager.pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailsVC", sender: pokeManager.pokemons[indexPath.row])
    }
    
}

// MARK: Type Picker

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokeManager.pokeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokeManager.pokeTypes[row].capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeSelectTextField.text = pokeManager.pokeTypes[row].capitalized
        typeSelectTextField.resignFirstResponder()
        self.startFiltering()
    }
}

// MARK: Catch Button

protocol CatchBtnDelegate: AnyObject {
    func didChangeStatusValue(id: Int, newValue: Bool)
}

extension HomeVC: CatchBtnDelegate {
    func didChangeStatusValue(id: Int, newValue: Bool) {
        self.pokeManager.updateCatchStatus(where: id, to: newValue)
        self.startFiltering()
    }
}

