import FirebaseStorage
import Foundation
import ZIPFoundation

@available(iOS 15.0, *)
public enum ModuleFirebaseStorage {
    /**
     List root files
     */
    public static func listRootFiles() async -> [StorageReference]{
        let storage = Storage.storage()
        let reference = storage.reference()
        
        do {
            let result = try await reference.listAll()
            return result.items
        } catch {
            return []
        }
    }
    
    /**
     Unzip file
     */
    public static func synchronizeFile(reference:StorageReference,
                                 maxSize: Int64 = 50 * 1024 * 1024,
                                 onComplete:((URL) -> Void)?
    ){
        
    }
    
    /**
     Unzip file
     */
    private static func unzipFile(data:Data, 
                                  reference:StorageReference,
                                  onComplete:((URL) -> Void)?){
        /**
         File Manager
         */
        let fileManager = FileManager.default
        
        /**
         Paths
         */
        let folderName = reference.name.components(separatedBy: ".").first!
        let appDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let tempDirectory = fileManager.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let destinationPath = appDirectory.appendingPathComponent(folderName)
        
        /**
         Unzip & clean
         */
        do {
            if fileManager.fileExists(atPath: destinationPath.path){
                try fileManager.removeItem(at: destinationPath)
            }
            try fileManager.createDirectory(at: destinationPath, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: tempDirectory)
            try fileManager.unzipItem(at: tempDirectory, to: destinationPath)
            try fileManager.removeItem(at: tempDirectory)
            onComplete?(destinationPath)
        } catch {
        }
    }
}
