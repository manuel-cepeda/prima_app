module DataReader
  def read_bata(path_to_file)
    begin
      sheet = book.worksheet 0
      sheet.each 2 do |row|
        unless row[0].blank?
          # Create model and save it to DB
          ...
        end
      end
    rescue Exception => e
      puts e
    end
  end
end