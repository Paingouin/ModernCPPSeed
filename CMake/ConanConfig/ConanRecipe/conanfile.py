from conans import ConanFile, CMake, tools


class NewLibConan(ConanFile):
    name = "Libraries"
    version = "0.1.0"
    license = "<Put the package license here>"
    author = "CAT"
    url = "<URL Here>"
    description = "<Description of NewLib here>"
    topics = ("<Put some tag here>", "<here>", "<and here>")
    settings = {
        "os" : ["Windows", "Linux"], 
        "compiler" : ["Visual Studio", "gcc"], 
        "build_type" : ["Debug", "Release"], 
        "arch" : ["x86_64"]
    }
    
    #generators = "cmake" no need to build.
    #exports_sources  = "newlib/*"  #This is used to save the binaries, in case of problems
    
    #no need for source and build step as we have already the binaries
    def configure(self):
        pass
      
    def requirements(self):
        pass
            
    def package(self):
        self.copy("*")
                
    def package_info(self):
        self.cpp_info.libs = self.collect_libs();

