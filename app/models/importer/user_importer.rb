class Importer::UserImporter < ActiveImporter::Base
  imports Employee
  column '姓名', :name
  column '邮箱', :email
  column 'QQ', :qq
  column '年龄', :age
  column '地址', :address
  column '组织架构', :organize_id do |name|
    Organize.find_by(name: name)
  end

  on :row_processing do
    #model.full_name = [row['First name'], row['Last name']].join(' ')
  end

  on :import_started do
    @row_count = 0
  end

  on :row_processed do
    @row_count += 1
  end

  on :import_finished do
    #send_notification("Data imported successfully!")
  end

  on :import_failed do |exception|
    #send_notification("Fatal error while importing data: #{exception.message}")
  end



end