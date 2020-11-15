class CustomFile
  def initialize(file)
    @file = file
  end

  def absolute_path
    exist?(error=1)
    File.absolute_path(@file)
  end

  def directory?
    exist?(error=1)
    File.directory?(@file)
  end

  def exist?(error=0)
    filepath = File.absolute_path(@file)
    status = File.exist?(filepath)
    if error > 0 and !status
      raise("There is no file #{@file} in the current directory")
    end
    status
  end

  def mtime
    exist?(error=1)
    File.mtime(@file)
  end
end

myfile = CustomFile.new('CustomFile.rb')
puts(myfile.exist?)
puts(myfile.directory?)
puts(myfile.absolute_path)
puts(myfile.mtime)