//
//  TeacherController.swift
//  apple_lab08_pract02_UIKit
//

import UIKit

struct Teacher {
    let name: String
    let course: String
    let initials: String
    let color: UIColor
}

class TeacherTableViewCell: UITableViewCell {
    static let identifier = "TeacherTableViewCell"

    private let avatarContainer = UIView()
    private let initialsLabel = UILabel()
    private let nameLabel = UILabel()
    private let courseLabel = UILabel()
    private let arrowImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .white

        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.layer.cornerRadius = 24
        avatarContainer.clipsToBounds = true
        contentView.addSubview(avatarContainer)

        initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        initialsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        initialsLabel.textAlignment = .center
        avatarContainer.addSubview(initialsLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)

        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        courseLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        contentView.addSubview(courseLabel)

        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        arrowImageView.image = UIImage(systemName: "chevron.right", withConfiguration: config) ?? UIImage(systemName: "chevron.down")
        arrowImageView.tintColor = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1.0)
        arrowImageView.contentMode = .scaleAspectFit
        contentView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            avatarContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarContainer.widthAnchor.constraint(equalToConstant: 48),
            avatarContainer.heightAnchor.constraint(equalToConstant: 48),

            initialsLabel.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: avatarContainer.centerYAnchor),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            nameLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),

            courseLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            courseLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: 14),
            courseLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            courseLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    func configure(with teacher: Teacher) {
        nameLabel.text = teacher.name
        courseLabel.text = teacher.course
        initialsLabel.text = teacher.initials
        initialsLabel.textColor = teacher.color
        avatarContainer.backgroundColor = teacher.color.withAlphaComponent(0.15)
    }
}

class TeacherController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    private let allTeachers: [Teacher] = [
        Teacher(name: "Richard Ricasca Portillo", course: "Aplicaciones Móviles Multiplataforma", initials: "RR", color: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)),
        Teacher(name: "Jeisson Daniel Paredes Cano", course: "Desarrollo de Aplicaciones Web Avanzado", initials: "JP", color: UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)),
        Teacher(name: "Renato Dietrich Usnayo Caceres", course: "Desarrollo de Aplicaciones Web Avanzado", initials: "RU", color: UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0)),
        Teacher(name: "Victor Alejandro Calvo Guzmán", course: "Desarrollo de Soluciones en la Nube", initials: "VC", color: UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0)),
        Teacher(name: "Jym Guillermo Manrique Delgado", course: "Diseño de Proyectos de Innovación", initials: "JM", color: UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1.0)),
        Teacher(name: "Ivan Gianfranco Yucra Yucra", course: "Integración de Sistemas Empresariales", initials: "IY", color: UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 1.0)),
        Teacher(name: "Yanira Shila Urbiola Gandarillas", course: "Marketing y Comercialización de Nuevos Productos", initials: "YU", color: UIColor(red: 0/255, green: 199/255, blue: 190/255, alpha: 1.0)),
        Teacher(name: "Brian Benjamin Pareja Meruvia", course: "Programación en Móviles Avanzado", initials: "BP", color: UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)),
        Teacher(name: "Fridda Nevenka Chara Quiroz", course: "Tutoría 5", initials: "FC", color: UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0))
    ]

    private var filteredTeachers: [Teacher] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teachers"
        view.backgroundColor = .white

        filteredTeachers = allTeachers
        setupSearchBar()
        setupTableView()
    }

    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 78, bottom: 0, right: 16)
        tableView.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
        tableView.tableFooterView = UIView()
        tableView.register(TeacherTableViewCell.self, forCellReuseIdentifier: TeacherTableViewCell.identifier)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 6),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeachers.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeacherTableViewCell.identifier, for: indexPath) as? TeacherTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredTeachers[indexPath.row])
        return cell
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredTeachers = allTeachers
        } else {
            filteredTeachers = allTeachers.filter { teacher in
                teacher.name.localizedCaseInsensitiveContains(searchText) ||
                teacher.course.localizedCaseInsensitiveContains(searchText)
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
