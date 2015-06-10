require "faker"
require "csv"
require "date"

class Person
	attr_accessor :first_name, :last_name, :email, :phone, :created_at

	def initialize(first_name, last_name, email, phone, created_at)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = created_at
	end
end

class ArrayPerson
	def self.number_of_person(number)
		@people_in_array = Array.new(number) { ArrayPerson.create_fake_person }
	end

	def self.create_fake_person
		@person = Person.new(Faker::Name.first_name, 
	         					Faker::Name.last_name, 
						        Faker::Internet.email, 
						        Faker::PhoneNumber.phone_number,
						        Time.now)
	end
	
end

class PersonWriter
	def initialize(file_name, people_list)
		@file_name = file_name
		@people_list = people_list
	end

	def create_csv
		CSV.open(@file_name, "wb") do |csv|
  		@people_list.each do |person|
  			csv << [person.first_name, 
  						person.last_name, 
  						person.email, 
  						person.phone, 
  						person.created_at 
  					 ]
  		end
		end
	end
end

class PersonParser
	def initialize(file_name)
		@file_name = file_name
		@people_array = []
	end

	def people
		CSV.foreach(@file_name) do |row|
			@people_array << Person.new(row[0], row[1], row[2], row[3], DateTime.parse(row[4]))
		end
		@people_array
	end
end


# p ArrayPerson.number_of_person(2)

# file = PersonWriter.new("file.csv", ["uno", "dos"])
# p file.create_csv

# WRITING FILE
# person_array = ArrayPerson.number_of_person(15)
# person_writer = PersonWriter.new("file.csv", person_array)
# person_writer.create_csv

# READING FROM FILE
parser = PersonParser.new('file.csv')
people_array = parser.people



# PRINT FIRST 10 PEOPLE IN ARRAY
# p people_array[0..9]

# UPDATE SOME PEOPLE
# person = people_array[0]
# person.first_name = "Mauricio"

# person_2 = people_array[1]
# person_2.first_name = "Daniel"

# person_3 = people_array[2]
# person_3.first_name = "Javier"

# WRITING FILE WITH UPDATED PEOPLE
# person_writer_2 = PersonWriter.new("file.csv", people_array)
# person_writer_2.create_csv

# SHOW FORMATTED DATETIME OF FIRST PERSON
# READING FROM FILE
# parser = PersonParser.new('file.csv')
# people_array = parser.people
# person = people_array[0]
# date = person.created_at
# date_year = date.year
# date_month = date.month
# date_day = date.day
# puts "#{date_year}-#{date_month}-#{date_day}"