defmodule Mimicron do
  @moduledoc """
  Experimental software.
  Purpose of the software is to trace callstack.
  Add use Mimicron in every module that you want to being traced
  If you want to disable tracing, add 'config :mimicron, active: false' to config/config.ex
  """
  alias Mimicron.Function

  defmacro __using__(_) do
    if Application.get_env(:mimicron, :active, true) do
      quote do
        import Kernel, except: [def: 2]
        import Mimicron, only: [def: 2]
      end
    end
  end

  defmacro def(head, body) do
    quote bind_quoted: [
            head: Macro.escape(head),
            body: Macro.escape(body)
          ] do
      {function, args} = Function.name_and_args(head)
      {arg_names, decorated_args} = Function.decorate_args(args)

      head =
        Macro.postwalk(
          head,
          fn
            {fun_ast, context, old_args} when fun_ast == function and old_args == args ->
              {fun_ast, context, decorated_args}

            other ->
              other
          end
        )

      file = __ENV__.file
      line = __ENV__.line
      module = __ENV__.module
      loc = "#{file}:#{line}"
      call = "#{module}.#{function}"
      log = "#{loc} #{call}"

      body =
        Keyword.update(body, :do, nil, fn b ->
          quote do
            IO.puts(unquote(log))
            unquote(b)
          end
        end)

      Kernel.def(unquote(head), unquote(body))
    end
  end
end
