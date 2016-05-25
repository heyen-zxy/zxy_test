class UserDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to
  def_delegator :@view, :user_path
  def_delegator :@view, :edit_user_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['User.updated_at']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['User.name', 'User.email', 'User.qq']
  end

  private

  def data
    records.map do |record|
      [
          link_to(record.name, user_path(record)),
                  record.email,
                  record.qq,
                  record.age,
                  record.address,
          link_to('编辑', edit_user_path(record)),
      link_to('删除', record, method: :delete,data: { confirm: '确定删除吗?' })
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    # insert query here
    User.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
