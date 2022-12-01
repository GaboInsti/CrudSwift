//
//  CoreDataManager.swift
//  Projecto
//
//  Created by CCDM09 on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Projecto")
        persistentContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error{
                fatalError("Core data failed\(error.localizedDescription)")
            }
            
        })
    }
    func guardarEmpleado(activo_opc:String, domicilio:String, empApeMat:String, empApePat:String, empId:String, puesto:String, telefono:String ){
        let emp = Empleado(context: persistentContainer.viewContext)
            emp.activo_opc = activo_opc
            emp.domicilio = domicilio
            emp.empApeMat = empApeMat
            emp.empApePat = empApePat
            emp.empId = empId
            emp.puesto = puesto
            emp.telefono = telefono
        do{
            try persistentContainer.viewContext.save()
            print("Empleado guardada")
        }
        catch{
            print ("falla")
        }
    }
    
    func leerEmpleado() -> [Empleado] {
        let fetchRequest : NSFetchRequest<Empleado> = Empleado.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerEmpleado(empId:String) -> Empleado?{
        let fetchRequest : NSFetchRequest<Empleado> = Empleado.fetchRequest()
        let predicate = NSPredicate(format: "empId = %@", empId)
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
            }
        catch{
            print("No se puede leer ese dato")
        }
        return nil
    }
    
    func actualizarEmpleado(empleado: Empleado){
        let fetchRequest : NSFetchRequest<Empleado> = Empleado.fetchRequest()
        let predicate = NSPredicate(format: "empId = %@",empleado.empId ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.activo_opc = empleado.activo_opc
            v?.domicilio = empleado.domicilio
            v?.empApeMat = empleado.empApeMat
            v?.empApePat = empleado.empApePat
            v?.empId = empleado.empId
            v?.puesto = empleado.puesto
            v?.telefono = empleado.telefono
            try persistentContainer.viewContext.save()
            print("Empleado actualizada")
        }catch{
            print("no se pudo actualizar")
        }
    }
    
    func borraEmpleado(empleado:Empleado){
        persistentContainer.viewContext.delete(empleado)
    }
}
