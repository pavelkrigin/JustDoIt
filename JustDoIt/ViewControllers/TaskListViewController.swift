//
//  ViewController.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 7.2.23..
//

import UIKit

final class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
