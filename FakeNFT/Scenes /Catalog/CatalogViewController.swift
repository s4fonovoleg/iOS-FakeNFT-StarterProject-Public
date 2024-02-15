import UIKit
import SnapKit
import ProgressHUD
import UIKit

class CatalogViewController: UIViewController {
    
    private var viewModel = CatalogViewModel()
    
    private let tableView : UITableView = {
        var table = UITableView()
        table.tableHeaderView = UIView()
        table.showsVerticalScrollIndicator = false
        table.rowHeight = 179
        return table
    }()
    
    private lazy var sortButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "text.justifyleft"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        errorBind()
        ProgressHUD.show()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupScreen()
        loadNfts()
    }
    
    @objc
    private func filterButtonTapped(){
        let filter = UIAlertController(title: "Сортировка", message: "", preferredStyle: .actionSheet)
        let filterByNftCount = UIAlertAction(title: "По количеству NFT", style: .default) { _ in
            self.viewModel.filterNfts(by: .byNftCount)
            self.tableView.reloadData()
        }
        let filterByNftName = UIAlertAction(title: "По названию", style: .default) { _ in
            self.viewModel.filterNfts(by: .byNftName)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel , handler: nil)
        filter.addAction(filterByNftName)
        filter.addAction(filterByNftCount)
        filter.addAction(cancelAction)
        present(filter, animated: true)
    }
    
    private func loadNfts() {
        viewModel.loadNft()
    }
    
    private func bind(){
        viewModel.change = {
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
    }
    
    private func errorBind(){
        viewModel.showError = {
            self.showError(ErrorModel(message: NSLocalizedString("Error.network", comment: ""),
                                      actionText: NSLocalizedString("Error.repeat", comment: ""),
                                      action: self.loadNfts))
        }
    }
    
    
    
    private func setupScreen(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        tableView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
    }
    
}



extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CatalogCell
        cell?.config(nft: viewModel.nfts[indexPath.row])
        cell?.separatorInset = .init(top: 0, left: tableView.frame.width / 2, bottom: 0, right: tableView.frame.width / 2)
        return cell ?? UITableViewCell()
    }
    
}

extension CatalogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CatalogViewController : ErrorView {}
