module DynamicTable
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def get_dynamic_class(date = Date.today)
      class_name = set_class_name(date)
      #see if it has already been defined
      class_name.constantize
    rescue NameError
      define_dynamic_class(date)
    end


    def create_table date=Date.today
      new_table_name = set_table_name date
      conn = ActiveRecord::Base.connection
      conn.execute "CREATE TABLE `#{new_table_name}` SELECT * FROM `#{table_name}` WHERE 1=2 " unless conn.table_exists? new_table_name
    end

    def union_table begin_date=Date.new(2016, 1, 1), end_date = Date.today
      dates = (begin_date..end_date).to_a.uniq{|x| x.strftime('%Y%m') }
      result = all
      dates.each do |date|
        result = result.union(get_dynamic_class(date).all) if ActiveRecord::Base.connection.table_exists? set_table_name(date)
      end
      result
    end


    private

    def set_table_name date = Date.today
      "#{table_name}_#{date_suffix date}"
    end

    def set_class_name(date = Date.today)
      "#{name}_#{date_suffix date}".classify
    end

    def date_suffix(date = Date.today)
      date.strftime '%Y_%m'
    end

    #创建动态的class
    def define_dynamic_class(date = Date.today)
      class_name = set_class_name date
      table_name = set_table_name date
      Object.const_set class_name, Class.new(ActiveRecord::Base) { self.table_name = "#{table_name}" }
      class_name.constantize
    end
  end


end

