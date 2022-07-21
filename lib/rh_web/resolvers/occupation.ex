defmodule RhWeb.Resolvers.Occupation do
  def get(%{id: occupation_id}, _context), do: Rh.get_occupation(occupation_id)
  def create(%{input: params}, _context), do: Rh.create_occupation(params)
  def delete(%{id: occupation_id}, _context), do: Rh.delete_occupation(occupation_id)
  def list(_context), do: Rh.list_occupations()
end
