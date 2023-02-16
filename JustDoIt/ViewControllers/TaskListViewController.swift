//
//  ViewController.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 7.2.23..
//

import UIKit
import CoreData

final class TaskListViewController: UITableViewController {
    
    private var fetchedResultsController = StorageManager.shared.getFetchedResultsController(entityName: "Task", keyForSort: "date")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTasks()
        
    }
    

}

// MARK: - Table View Data Source
extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard fetchedResultsController.object(at: indexPath) is Task else { return cell } // Вызов метода fetchedResultsController.object(at:) возвращает объект с типом NSManagedObject из массива fetchedResultsController.fetchedObjects, который мы затем приводим к типу Task с помощью оператора as?.
        let task = fetchedResultsController.object(at: indexPath) as? Task
        cell.contentConfiguration = setContentForCell(with: task)
        
        return cell
    }
}

// MARK: - NSFetchResultsControllerDelegate
extension TaskListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates() // Метод вызывается перед тем, как NSFetchedResultsController начнет обновлять данные. Он предназначен для того, чтобы приложение могло начать обновлять пользовательский интерфейс до того, как изменения будут произведены. Что бы подготовить табличное представление к обновлению мы вызываем у tableView метод beginUpdates()
    }
}

// MARK: - Private Methods
extension TaskListViewController {
    private func setupNavigationBar() {
        title = "Task list" // меняем заголовок экрана на Task list
        let fontName = "Apple SD Gothic Neo Bold" // определяем название шрифта для заголовка
        navigationController?.navigationBar.prefersLargeTitles = true // делаем заголовок большим
        
        let navBarAppearance = UINavigationBarAppearance() // создаем экземпляр класса UINavigationBarAppearance, который может использоваться для настройки внешнего вида навигационной панели
        navBarAppearance.configureWithOpaqueBackground() // устанавливаем для навигационной панели непрозрачный фон
        
        navBarAppearance.titleTextAttributes = [
            .font: UIFont(name: fontName, size: 19) ?? UIFont.systemFont(ofSize: 19), // задаем ранее выбраный шрифт
                .foregroundColor: UIColor.white // и белый цвет для заголовка
        ]
        
        navBarAppearance.titleTextAttributes = [
            .font: UIFont(name: fontName, size: 35) ?? UIFont.systemFont(ofSize: 35),
            .foregroundColor: UIColor.white // задаем теже аттрибуты для большого заголовка
        ]
        
        navBarAppearance.backgroundColor = UIColor( // задаём свой цает для навигационной панели
            red: 97/255,
            green: 210/255,
            blue: 255/255,
            alpha: 255/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance // применяем заданные аттрибуты навигационной панели для большого заголовка
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance // применяем теже аттрибуты для маленького заголовка
                        
    }
    
    private func fetchTasks() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    private func setContentForCell(with task: Task?) -> UIListContentConfiguration {
        var content = UIListContentConfiguration.cell()
        
        content.textProperties.font = UIFont(
        name: "Avenir Next Medium", size: 23
        ) ?? UIFont.systemFont(ofSize: 23)
        
        content.textProperties.color = .darkGray
        content.text = task?.title
        
        return content
    }
    
}
