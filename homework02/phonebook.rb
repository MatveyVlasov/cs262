require "sequel"

COUNTRIES = %w[Россия Канада США Германия Великобритания Финляндия Швеция Норвегия Польша Беларусь]

class PhoneBook
  def initialize(surname, name, patronymic, phone, *args)
    field = Validation.new
    @surname = field.valid('text', surname)
    @name = field.valid('text', name)
    @patronymic = field.valid('text', patronymic)
    @phone = field.valid('number', phone)
    @country = field.valid('country', args[0][:country])
    @birthdate = field.valid('text', args[0][:birthdate])
    @org = field.valid('text', args[0][:org])
    @position = field.valid('text', args[0][:position])
    insert
  end

  def insert
    data = Conversion.new([@surname, @name, @patronymic, @phone, @country, @birthdate, @org, @position]).convert
    status = DATABASE.fetch(data)
    if status
      puts("Contact added")
    end
  end
end

class Validation
  def valid?(type, input)
    if input.nil?
      return true
    end
    if type == 'text' and input.count("0-9") > 0
      return false
    end
    if type == 'number' and input.count("0-9+") < input.length
      return false
    end
    if type == 'country' and not COUNTRIES.include?(input)
      return false
    end
    true
  end

  def valid(type, input)
    if valid?(type, input)
      return input
    end
    raise("Data Input Error in #{input}")
  end
end

class DataBase
  def connect
    @db = Sequel.connect('sqlite://phonebook.db')
    puts("Successful database connection")
  end

  def fetch(str)
    @db.run("CREATE TABLE IF NOT EXISTS phonebook (ID INTEGER PRIMARY KEY, surname TEXT NOT NULL, name TEXT NOT NULL,
             patronymic TEXT NOT NULL, phone TEXT NOT NULL UNIQUE, country TEXT, birthdate TEXT, org TEXT, position TEXT)")

    begin
     @db.run(str)
    rescue
      raise("This record already exists")
    end
    true
  end

  def select
    @db["SELECT * FROM phonebook"].each do |row|
      puts(row)
    end
  end
end

class Conversion
  def initialize(data)
    @data = data
  end

  def convert
    str = "INSERT INTO phonebook(surname, name, patronymic, phone, country, birthdate, org, position) VALUES("
    @data.each do |i|
      str += "'#{i}', "
    end
    str[-2] = ')'
    str
  end
end

DATABASE = DataBase.new
DATABASE.connect
PhoneBook.new('Варламов', 'Илья', 'Александрович', '+79143335599', country: 'Россия', position: 'Журналист', org: "Рога и Копыта")
DATABASE.select