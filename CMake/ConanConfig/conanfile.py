from conans import ConanFile, CMake

class RequirementConan(ConanFile):
   settings = "os", "compiler", "build_type", "arch"
   requires = "sdl2/2.0.14@bincrafters/stable","freetype/2.10.0@bincrafters/stable","glew/2.1.0@bincrafters/stable","gtest/1.8.1@bincrafters/stable","glm/0.9.9.8" # comma-separated list of requirements
   generators = "cmake_multi"
   default_options = {"sdl2:shared": True, "glew:shared" : False, "gtest:build_gmock": True, "gtest:shared" :False}

   def imports(self):
      self.copy("*.dll",  dst="bin"+"/" +str(self.settings.os)+"/"+str(self.settings.build_type), src="bin")
      self.copy("*.dylib", dst="bin"+"/"+ str(self.settings.os)+"/"+str(self.settings.build_type), src="lib")