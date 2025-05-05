//
//  CoreDataRelationshipsExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 05/10/2024.
//



// MARK: - NOTES

// MARK: 16 - Core Data relationships, predicates, and delete rules in Xcode
///
/// - dla danego modelu, np. `CoreDataRelationships.xcdatamodeld` możemy tworzyć wiele `Entity`
/// - możemy również tworzyć relacje pomiędzy poszczególnymi `Entity` w zakładce `Relationships`
/// - relacje mogą być oznaczone `To One` czyli jedna do jednej lub `To Many` czyli jedna do wielu
/// - aby posortować elementy przypisujemy wartość do `request.sortDescriptors` typu `NSSortDescriptor`
/// - aby przefiltrować elementy przypisujemy wartość do `request.predicate` typu `NSPredicate`
/// - ważną zasadą usuwania elementów z bazy danych jest ustawienie `Delete Rule` które znajduje się po kliknięciu `Cmd+Option+0` w ostatniej zakładce - wcześniej musimy zaznaczyć wybraną `Relationship` dla wybranego `Entity`
/// - dla przykładu usuwamy wybrany `Department` i dla `Relationships -> employees` ustawiamy kolejne `Delete Rule`
/// - `Nullify` - po usunięciu działu pracownicy należący do niego zostaną w bazie ale już nie będą mieć przypisanego usuniętego działu
/// - `Cascade` - po usunięciu działu pracownicy należący do niego również zostaną usunięci z bazy
/// - `Deny` - w tym przypadku najpierw muszą być usunięci wszyscy pracownicy danego działu żeby dział mógł zostać usunięty, bo w innym wypadku podczas próby usunięcia działu wystąpi błąd



// MARK: - CODE

import CoreData
import SwiftUI

final class CoreDataRelationshipsExampleManager {
    
    // MARK: - Properties
    
    static let shared = CoreDataRelationshipsExampleManager()
    
    private let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    // MARK: - Init
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataRelationships")
        container.loadPersistentStores { description, error in
            if let error { print(error.localizedDescription) }
        }
        context = container.viewContext
    }
    
    // MARK: - Methods
    
    func save() {
        try? context.save()
    }
}



final class CoreDataRelationshipsExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let manager = CoreDataRelationshipsExampleManager.shared
    
    @Published
    private(set) var businesses: [BusinessEntity] = []
    
    @Published
    private(set) var departments: [DepartmentEntity] = []
    
    @Published
    private(set) var employees: [EmployeeEntity] = []
    
    // MARK: - Init
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    // MARK: - Methods
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
        // newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to the new business
        // newBusiness.employees = [employees[1]]
        
        // add new business to the existing department
        // newBusiness.addToDepartments(...)
        
        // add new business to existing employee
        // newBusiness.addToEmployees(...)
        
        save()
    }
    
    func updateBusiness(_ business: BusinessEntity) {
        business.addToDepartments(departments[1])
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        // newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func deleteDepartment() {
        manager.context.delete(departments[2])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Mike"
        newEmployee.age = 43
        newEmployee.joinedDate = Date()
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        save()
    }
    
    private func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        // request.predicate = NSPredicate(format: "name == %@", "Apple")
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \BusinessEntity.name,
                ascending: true
            )
        ]
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        // request.predicate = NSPredicate(format: "business == %@", businesses[0])
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}



struct CoreDataRelationshipsExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = CoreDataRelationshipsExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Button("Add business") {
                    viewModel.addBusiness()
                }
                Button("Add department") {
                    viewModel.addDepartment()
                }
                Button("Add employee") {
                    viewModel.addEmployee()
                }
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(viewModel.businesses) { business in
                            businessView(business)
                        }
                    }
                    .padding()
                }
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(viewModel.departments) { department in
                            departmentView(department)
                        }
                    }
                    .padding()
                }
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(viewModel.employees) { employee in
                            employeeView(employee)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Relationships")
            .scrollIndicators(.hidden)
        }
    }
    
    // MARK: - Subviews
    
    private func businessView(_ business: BusinessEntity) -> some View {
        VStack(alignment: .leading) {
            Text("Name: \(business.name ?? "")")
                .font(.title3.weight(.bold))
            if let departments = business.departments?.allObjects as? [DepartmentEntity],
               !departments.isEmpty {
                Text("Departments")
                    .font(.headline)
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            if let employees = business.employees?.allObjects as? [EmployeeEntity],
               !employees.isEmpty {
                Text("Employees")
                    .font(.headline)
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.gray.opacity(0.15))
        )
        .onTapGesture {
            viewModel.updateBusiness(business)
        }
    }
    
    private func departmentView(_ department: DepartmentEntity) -> some View {
        VStack(alignment: .leading) {
            Text("Name: \(department.name ?? "")")
                .font(.title3.weight(.bold))
            if let businesses = department.businesses?.allObjects as? [BusinessEntity],
               !businesses.isEmpty {
                Text("Businesses")
                    .font(.headline)
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            if let employees = department.employees?.allObjects as? [EmployeeEntity],
               !employees.isEmpty {
                Text("Employees")
                    .font(.headline)
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.gray.opacity(0.15))
        )
        .onTapGesture {
            viewModel.deleteDepartment()
        }
    }
    
    private func employeeView(_ employee: EmployeeEntity) -> some View {
        VStack(alignment: .leading) {
            Text("Name: \(employee.name ?? "")")
                .font(.title3.weight(.bold))
            Text("Age: \(employee.age)")
                .font(.title3.weight(.bold))
            Text("Date: \(employee.joinedDate ?? Date())")
                .font(.title3.weight(.bold))
            
            if let business = employee.business {
                Text("Business")
                    .font(.headline)
                Text(business.name ?? "")
            }
            if let department = employee.department {
                Text("Department")
                    .font(.headline)
                Text(department.name ?? "")
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.gray.opacity(0.15))
        )
    }
}
