class OrganizesDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to
  def_delegator :@view, :organize_path
  def_delegator :@view, :edit_organize_path
  def_delegator :@view, :organizes_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= []
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= []
  end

  private

  def data
    records.map do |record|
      [
          link_to(record.name, organize_path(record)),
          record.children.count == 0 ? '' :link_to(record.children.count, organizes_path(id: record.id)),
          link_to('编辑', edit_organize_path(record)),
          link_to('删除', record, method: :delete,data: { confirm: '确定删除吗?' })

        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    pp params[:id], '11111111111'
    if params[:id].present?
      Organize.find_by_id(params[:id]).children
    else
      Organize.where(ancestry: nil)
    end

    # insert query here
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
