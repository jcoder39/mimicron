defmodule Mimicron.Function do
  def name_and_args({:when, _, [short_head | _]}) do
    Mimicron.Function.name_and_args(short_head)
  end

  def name_and_args(short_head) do
    Macro.decompose_call(short_head)
  end

  def decorate_args([]), do: {[], []}

  def decorate_args(args_ast) do
    Enum.with_index(args_ast)
    |> Enum.reduce([], &decorate_arg/2)
    |> Enum.reverse()
    |> Enum.unzip()
  end

  defp decorate_arg({arg_ast, index}, list) do
    decorated_arg =
      if elem(arg_ast, 0) == :\\ do
        {:\\, _, [{optional_name, _, _}, _]} = arg_ast
        {Macro.var(optional_name, nil), arg_ast}
      else
        arg_name = Macro.var(:"arg#{index}", __MODULE__)

        full_arg =
          quote do
            unquote(arg_ast) = unquote(arg_name)
          end

        {arg_name, full_arg}
      end

    [decorated_arg | list]
  end
end
