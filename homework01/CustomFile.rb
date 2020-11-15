class CustomFile
  def initialize(file)
    @file = file
  end

  def absolute_path
    if exist?
      File.absolute_path(@file)
    else
      raise("There is no file #{@file} in the current directory")
    end
  end

  def directory?
    if exist?
      File.directory?(@file)
    else
      raise("There is no file #{@file} in the current directory")
    end
  end

  def exist?
    filepath = File.absolute_path(@file)
    File.exist?(filepath)
  end

  def mtime
    File.mtime(@file)
  end
end

myfile = CustomFile.new('testdirectory')
puts(myfile.exist?)
puts(myfile.directory?)
puts(myfile.absolute_path)
puts(myfile.mtime)