##
# class to manage list of contacts
#
class Contacts

  ##
  # create a Contacts object from string of pipe delimited ("|") fields, one record per line
  # e.g. "Brandon Faloona|Seattle|WA|bfaloona@uw.edu\nBarack Obama|Washington|DC|president@wh.gov"
  #
  def initialize data
    @raw_entries = data.split("\n")
    # set @contacts to an array of contacts
    @contacts = @raw_entries.collect do |line|
      contact_hash line
    end
  end

  def raw_entries
    @raw_entries
  end

  ##
  # the list of fields expected in input lines
  #
  def fields
    [:full_name, :city, :state, :email]
  end

  ##
  # create a contact (a hash) from raw input line
  #
  def contact_hash line
    values = line.split("|")
    Hash[fields.zip values]
  end

  ##
  # return a comma separated list of formatted email addresses
  #
  def email_list
    @raw_entries.collect do |line|
      name, city, state, email = line.split("|")
      format_email_address name, email.chomp
    end.join(", ")
  end

  ##
  # returns "Display Name" <email@address> given name and email
  #
  def format_email_address name, email
    %{\"#{name}\" <#{email}>}
  end

  def num_entries
    @raw_entries.length
  end

  def contact index
    @contacts[index.to_i]
  end

  #########

  def format_contact contact
    # the following line changes contact[:city] to "Seattle WA":
    # %{\"#{contact[:full_name]} of #{contact[:city] << " " << contact[:state]}\" <#{contact[:email]}>}
    %{\"#{contact[:full_name]} of #{contact[:city]} #{contact[:state]}\" <#{contact[:email]}>}
  end

  def all
    @contacts
  end

  def formatted_list
    @contacts.map {|line| format_contact line }.join("\n")
    # @contacts.each_value.format_contact()
    # @contacts.collect {|line| format_contact line }
    # below just gives error (i.e., no output) if .join("\n") not on it
    # @contacts.map {|line| format_contact line }
    # @contacts.each {|line| print line }
    # contacts.each { |x| format_contact x } 
    # @contacts.count
    # format_contact @contacts[0..@contacts.count]
    #  contact_hash.each { |h| format_contact h }
    #  contact_hash[1}
    # format_contact @contacts[0] 
    # @contacts.each_index { |i| format_contact @contacts[i] }
    # @contacts.each.format_contact
    #  @contacts.each.contact_hash.format_contact
    # temp_str = ""
    # str = @contacts.each do |i|
    #   format_contact i
    # end
    # print @contacts.count
    # format_contact @contacts[0..num_entries.to_i]
  end

  def full_names
    @contacts.map do |line|
      line[:full_name]
    end
  end

  def cities
    @contacts.map do |line|
      line[:city]
    end.uniq
  end

  def append_contact contact
    @contacts.push(contact)
  end

  def delete_contact index
    @contacts.delete_at(index.to_i)
  end

  def search string
    @contacts.map {|line| line if line.value?(string) }.compact
  end

  def all_sorted_by field
    @contacts.map.sort_by { |x| x[field] }
  end
  
end
