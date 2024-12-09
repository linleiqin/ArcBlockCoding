import Foundation
import UIKit
import SnapKit
import MJRefresh
import SVGKit


class BlogListViewController: BaseViewController {
	
	private var blogList: [BlogModel] = []
	private var currentPage = 1
	private let tableView = UITableView()
	let titleButton = UIButton(type: .custom)
	
	var filterIDs:[Label] = []
	var showAll = true
	var newest = true
	
	
	private lazy var filterViewController: FilterViewController = {
		let controller = FilterViewController()
		controller.onLabelsSelected = { selectedLabels in
			self.filterIDs = selectedLabels
			self.refreshData()
		}
		return controller
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let filterButtonImage = SVGKImage(named: "icon_filter")?.uiImage
		let filterButton = UIBarButtonItem(image: filterButtonImage, style: .plain, target: self, action: #selector(filterButtonTapped))
		filterButton.tintColor = ColorUtil.textColor
		self.navigationItem.rightBarButtonItem = filterButton
		
		titleButton.setTitle("全部文章", for: .normal)
		titleButton.setImage(UIImage(named: "icon_refresh"), for: .normal)
		titleButton.tintColor = ColorUtil.textColor

		var config = UIButton.Configuration.plain()
		config.titlePadding = 8
		config.imagePadding = 8
		config.imagePlacement = .trailing
		titleButton.configuration = config
		self.navigationItem.titleView = titleButton
		titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
		
		setupUI()
		fetchBlogList(page: currentPage)
		filterViewController.loadLabels()
	}
	
	@objc func titleButtonTapped() {
		if !loadingNetwork {
			self.showAll = !self.showAll
			titleButton.setTitle(self.showAll ? "全部文章" : "Blogs", for: .normal)
			refreshData()
		}

	}
	
	@objc func filterButtonTapped() {
		filterViewController.show()
	}
	
	private func setupUI() {
		tableView.register(BlogCell.self, forCellReuseIdentifier: "BlogCell")
		tableView.backgroundColor = ColorUtil.backgroundColor
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(0)
			make.left.right.bottom.equalToSuperview()
		}
		let headerView = BlogHeaderView(frame: CGRect(x: 0, y: 0, width: LayoutUtil.screenWidth, height: 56))
		headerView.onSelected = { selectIndex in
			self.newest = selectIndex == 0
			self.fetchBlogList(page: 1)
		}
		tableView.tableHeaderView = headerView
		setupRefresh()
	}
	
	private func setupRefresh() {
		tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
		tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
	}
	
	
	var loadingNetwork = false
	private func fetchBlogList(page: Int) {
		if loadingNetwork {
			//TODO：弹Toast
			return
		}
		self.loadingNetwork = true
		Task {
			do {
				let pageSize = 20
				let selectedIDs = filterIDs.map { $0.id }

				let blogList = try await ServiceBlog.shared.fetchBlogList(page: page, size: pageSize,showAll: self.showAll,filterIds: selectedIDs ,newest: self.newest)
				
				if page == 1 {
					self.blogList = blogList
				} else {
					self.blogList.append(contentsOf: blogList)
				}
				
				DispatchQueue.main.async {
					self.tableView.mj_header?.endRefreshing()
					self.tableView.mj_footer?.endRefreshing()
					self.tableView.mj_footer?.resetNoMoreData()
					self.tableView.reloadData()
					if blogList.count < pageSize {
						if blogList.isEmpty {
							
						}
						self.tableView.mj_footer?.endRefreshingWithNoMoreData()
					}
					self.loadingNetwork = false

				}
			} catch {
				print("Error fetching blog list: \(error)")
				DispatchQueue.main.async {
					self.tableView.mj_header?.endRefreshing()
					self.tableView.mj_footer?.endRefreshing()
					self.loadingNetwork = false
				}
				
			}
		}
	}
	
	@objc private func refreshData() {
		currentPage = 1
		fetchBlogList(page: currentPage)
	}
	
	@objc private func loadMoreData() {
		currentPage += 1
		fetchBlogList(page: currentPage)
	}
}

extension BlogListViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return blogList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
		let blog = blogList[indexPath.row]
		cell.configure(with: blog)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let blog = blogList[indexPath.row]

		let controller = BlogDetailViewController(blogModel: blog)
		self.navigationController?.pushViewController(controller, animated: true)
	}
}
