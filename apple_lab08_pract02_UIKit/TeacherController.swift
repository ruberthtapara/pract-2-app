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

class TeacherCell: UITableViewCell {
    static let identifier = "TeacherCell"

    @IBOutlet weak var avatarContainer: UIView?
    @IBOutlet weak var initialsLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var courseLabel: UILabel?

    func configure(with teacher: Teacher) {
        nameLabel?.text = teacher.name
        courseLabel?.text = teacher.course
        initialsLabel?.text = teacher.initials
        initialsLabel?.textColor = teacher.color
        avatarContainer?.backgroundColor = teacher.color.withAlphaComponent(0.15)
        avatarContainer?.layer.cornerRadius = 24
        avatarContainer?.clipsToBounds = true
    }
}

class TeacherController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let allTeachers: [Teacher] = [
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

    var filteredTeachers: [Teacher] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teachers"
        view.backgroundColor = .white

        filteredTeachers = allTeachers

        if searchBar == nil {
            setupProgrammaticViews()
        } else {
            searchBar.delegate = self
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 78
        }
    }

    private func setupProgrammaticViews() {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search"
        sb.delegate = self
        sb.searchBarStyle = .minimal
        view.addSubview(sb)

        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.rowHeight = 78
        tv.separatorInset = UIEdgeInsets(top: 0, left: 78, bottom: 0, right: 16)
        view.addSubview(tv)

        NSLayoutConstraint.activate([
            sb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sb.heightAnchor.constraint(equalToConstant: 44),

            tv.topAnchor.constraint(equalTo: sb.bottomAnchor, constant: 6),
            tv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.searchBar = sb
        self.tableView = tv
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeachers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell") as? TeacherCell {
            cell.configure(with: filteredTeachers[indexPath.row])
            return cell
        }

        // Fallback programmatic cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DefaultCell")
        let teacher = filteredTeachers[indexPath.row]
        cell.textLabel?.text = teacher.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        cell.detailTextLabel?.text = teacher.course
        cell.detailTextLabel?.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
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
