//
//  ViewController.swift
//  AsyncAwaitMVVM
//
//  Created by PHN Tech 2 on 19/07/23.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = GetData()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiConfiguration()
    }

    func apiConfiguration(){
        getData()
        observEvent1()
        observEvent2()
    }
    
    func getData(){
        viewModel.getData()
    }
    
    func observEvent1(){
        viewModel.eventHandler = {[weak self] event in
            guard self != nil else {return}
            print(event)
            
            switch event{
            case .startLoading:
                break
            case .stopLoading:
                break
            case .reloadData:
                break
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    func observEvent2(){
        viewModel.eventHandler2 = {[weak self] event in
            guard let self = self else {return}
            print(event)
            
            switch event{
            case .startLoading:
                break
            case .stopLoading:
                break
            case .reloadData:
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                break
            case .error(let error):
                print(error)
                break
            }
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "CellS", for: indexPath)
        cell.textLabel?.text = viewModel.albums[indexPath.row].title
        cell.detailTextLabel?.text = String(viewModel.posts[indexPath.row].id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
