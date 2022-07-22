defmodule RhWeb.Resolvers.Department do
  def get(%{id: department_id}, _context), do: Rh.get_department(department_id)
  def create(%{input: params}, _context), do: Rh.create_department(params)
  def delete(%{id: department_id}, _context), do: Rh.delete_department(department_id)
  def list(_params, _context), do: Rh.list_departments()
  def get_by_code(%{code: code}, _context), do: Rh.get_department_by_code(code)
end
