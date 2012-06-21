class MigrationHelper
  def MigrationHelper.constraint_name(from_table, to_table, const_name)
    const_name ? const_name : "fk_#{from_table}_#{to_table}"
  end
  def MigrationHelper.foreign_key(from_table, from_column, to_table, const_name=nil, on_delete='RESTRICT', on_update='RESTRICT')
    "alter table #{from_table}
      add constraint #{constraint_name(from_table, to_table, const_name)}
      foreign key (#{from_column})
      references #{to_table}(id)
      on delete #{on_delete}
      on update #{on_update}"
  end
  def MigrationHelper.drop_foreign_key(from_table, to_table, const_name=nil)
    "alter table #{from_table} drop constraint #{constraint_name(from_table, to_table, const_name)}"
  end
end