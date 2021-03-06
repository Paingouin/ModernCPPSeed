from conans import ConanFile, CMake

class RequirementConan(ConanFile):
   settings = "os", "compiler", "build_type", "arch"
   requires = "freetype/2.10.0","glew/2.2.0","gtest/1.8.1","glm/0.9.9.8" # comma-separated list of requirements
   generators = "cmake_multi"
   default_options = {"sdl2:shared": True, "glew:shared" : False, "gtest:build_gmock": True, "gtest:shared" :False}

   def imports(self):
      self.copy("*.dll",  dst="bin"+"/" +str(self.settings.os)+"/"+str(self.settings.build_type), src="bin")
      self.copy("*.pdb",  dst="bin"+"/" +str(self.settings.os)+"/"+str(self.settings.build_type), src="bin")
      self.copy("*.so*",  dst="bin"+"/" +str(self.settings.os)+"/"+str(self.settings.build_type), src="bin")
      self.copy("*.so*",  dst="bin"+"/" +str(self.settings.os)+"/"+str(self.settings.build_type), src="lib")
      self.copy("*.dynlib", dst="bin"+"/"+ str(self.settings.os)+"/"+str(self.settings.build_type), src="lib")
      #TODO(Jordan) : check the install process