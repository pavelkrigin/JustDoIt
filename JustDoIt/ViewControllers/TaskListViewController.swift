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
        fetchedResultsController.delegate = self
        
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

// MARK: - TableView Delegate
extension TaskListViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in // 1
            if let task = self.fetchedResultsController.object(at: indexPath) as? Task { // 2
                StorageManager.shared.delete(task: task) // 3
            }
        }
        
        deleteAction.image = UIImage(systemName: "trash") // 4
        
        return UISwipeActionsConfiguration(actions: [deleteAction]) // 5
    }
}


// MARK: - NSFetchResultsControllerDelegate
extension TaskListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // Метод вызывается перед тем, как NSFetchedResultsController начнет обновлять данные. Он предназначен для того, чтобы приложение могло начать обновлять пользовательский интерфейс до того, как изменения будут произведены. Что бы подготовить табличное представление к обновлению мы вызываем у tableView метод beginUpdates().
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {  // Метод вызывается каждый раз, когда NSFetchedResultsController обнаруживает изменения в данных. Этот метод предоставляет информацию о типе изменения (например, вставка, удаление, изменение или перемещение), а также индексы для объектов, которые были изменены. Метод используется для того, чтобы вызвать соответствующие методы UITableView, такие как insertRows(at:with:), deleteRows(at:with:), reloadRows(at:with:) или moveRow(at:to:), чтобы обновить таблицу в соответствии с изменениями данных. В данном случае мы пока обрабатываем кейсы для добавления и удаления задачи.
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // 3Метод вызывается один раз после того, как все изменения, которые были обнаружены NSFetchedResultsController, были обработаны методом controller(_:didChange:at:for:newIndexPath:). Этот метод используется, чтобы завершить обновление интерфейса пользователя и произвести любые другие необходимые действия после обновления данных. Чтобы завершить анимацию и обновить табличное представление мы вызываем у tableView метод endUpdates()        tableView.endUpdates()
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
