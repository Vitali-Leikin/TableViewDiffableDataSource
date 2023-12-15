//
//  ViewController.swift
//  TableCode
//
//  Created by Vitali on 14/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum TableSection{
        case main
    }

   lazy var tableView: UITableView = {
        let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints = false
     //  table.dataSource = self
       table.delegate = self
       table.estimatedRowHeight = 140
       table.rowHeight = 100
    //    table.isEditing = true
       table.register(CustomTableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellId)
     //  table.separatorStyle = .none
    
       return table
    }()
    
    var dataModels: [User] = []
    var dataSourse: UITableViewDiffableDataSource<TableSection, User>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUITableView()
        dataModels = createUser()
        setupNavigationBar()
        setupDataSourse()
    }
    
    // Новый способ работы с таблицами

    func setupDataSourse(){
        dataSourse = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, user in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellId, for: indexPath) as! CustomTableViewCell
            cell.configure(user: user)
            return cell
        })
        updateDataSourse(with: dataModels)
    }
    
    
    func updateDataSourse(with users: [User]){
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, User>()
        // create section
        snapshot.appendSections([.main])
        snapshot.appendItems(dataModels)
        dataSourse?.defaultRowAnimation = .left
        dataSourse?.apply(snapshot)
    }
    
    func createUser() -> [User]{
        var user = Array<User>()
        for i in 0..<5{
            user.append(User(name: "NAme name name name \(i)", age: Int.random(in: 10...30)))
        }
        return user
    }
    
    func setupNavigationBar(){
        
        let editingAction = UIAction { [self]_ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
            guard var snap = dataSourse?.snapshot() else{return }
            snap.moveItem(snap.itemIdentifiers.first!, afterItem: snap.itemIdentifiers.last!)
            dataSourse?.apply(snap)
        }
        
        let addAction = UIAction { [self] _ in
            guard var snap = dataSourse?.snapshot() else{return }
            snap.appendItems([User(name: "New", age: 100)])
            dataSourse?.apply(snap)
            
          //  self.dataModels.append(User(name: "New", age: 1000 ))
          //  updateDataSourse(with: dataModels)
            }
        
        let moveAction = UIAction{ [self] _ in
            guard var snap = dataSourse?.snapshot() else{return }
            snap.moveItem(snap.itemIdentifiers.first!, afterItem: snap.itemIdentifiers.last!)
            dataSourse?.apply(snap)

        }
        
        
        navigationItem.title = "Table"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editingAction, menu: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)

    }
    
    func setupUITableView(){
        
        view?.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view .topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
      
    }
    


}




extension ViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        dataModels.count
//    }
    
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellId, for: indexPath) as! CustomTableViewCell
//        
//        let model = dataModels[indexPath.row]
//        cell.configure(user: model)
//        
////        var listConfigure = cell.defaultContentConfiguration()
////        var backgroundConfigure = cell.defaultBackgroundConfiguration()
////        
////        listConfigure.text = dataModels[indexPath.row].name
////        listConfigure.secondaryText = String(dataModels[indexPath.row].age)
////        listConfigure.secondaryTextProperties.font = UIFont.boldSystemFont(ofSize: 30)
////        listConfigure.image = dataModels[indexPath.row].avatar
////        
////        backgroundConfigure.backgroundColor = .cyan
////        backgroundConfigure.cornerRadius = 10
////        backgroundConfigure.backgroundInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
////        
////        cell.contentConfiguration = listConfigure
////        cell.backgroundConfiguration = backgroundConfigure
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let user =  dataModels[sourceIndexPath.row]
//        dataModels.remove(at: sourceIndexPath.row)
//        dataModels.insert(user, at: destinationIndexPath.row)
//      //  tableView.reloadData()
//        //tableView.reloadRows(at: [sourceIndexPath,destinationIndexPath], with: .automatic )
//    }
    
    
}
